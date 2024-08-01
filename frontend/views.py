from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_GET
from django.shortcuts import get_object_or_404
from django.urls import reverse
from .models import Institute, Course, SubCourse, Topic, CourseRoom, User, UserProgress, CustomUser
from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.forms import AuthenticationForm
from .forms import SignUpForm

# Create your views here.

def index(request):
    form = AuthenticationForm()
    return render(request, 'index.html', {'form': form})

def dashboard(request):
    user = authenticate(request, username='rohan', password='Admin@123')
    if user:
        login(request, user)
    return render(request, 'dashboard.html')

def signup_view(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=password)
            login(request, user)
            return redirect('/')
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                    return JsonResponse({'success': True, 'redirect_url': reverse('dashboard')})
                else:
                    return redirect('dashboard')
        if request.headers.get('x-requested-with') == 'XMLHttpRequest':
            return JsonResponse({'success': False, 'errors': form.errors})
    else:
        form = AuthenticationForm()
    return redirect('/')  # Redirect to index page where the modal will be handled

def logout_view(request):
    logout(request)
    return redirect('/')


from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required


@login_required
@require_POST
def join_course_room(request, course_slug):
    try:
        course = Course.objects.get(slug=course_slug)
        course_room, created = CourseRoom.objects.get_or_create(course=course)
        course_room.members.add(request.user)
        return JsonResponse({'success': True, 'message': 'Joined course room successfully'})
    except Course.DoesNotExist:
        return JsonResponse({'success': False, 'message': 'Course not found'}, status=404)
    except Exception as e:
        return JsonResponse({'success': False, 'message': str(e)}, status=500)
    


from collections import defaultdict

@require_GET
def get_institute_nodemap(request, institute_slug):
    # institute = get_object_or_404(Institute.objects.prefetch_related(
    #     'courses__subcourses__topics'
    # ), name__iexact=institute_name)

    # unique_subcourses = {}
    # unique_topics = {}

    # def get_or_create_node(node_dict, node_id, node_data):
    #     if node_id not in node_dict:
    #         node_dict[node_id] = node_data
    #     return node_dict[node_id]

    # mindmap_data = {
    #     "data": {
    #         "id": "root",
    #         "topic": institute.name,
    #         "children": []
    #     }
    # }

    # for course in institute.courses.all():
    #     course_data = {
    #         "id": f"course_{course.id}",
    #         "topic": course.name,
    #         "background-color": "#1abc9c",
    #         "children": []
    #     }

    #     for subcourse in course.subcourses.all():
    #         subcourse_data = get_or_create_node(unique_subcourses, subcourse.id, {
    #             "id": f"subcourse_{subcourse.id}",
    #             "topic": subcourse.name,
    #             "background-color": "#34495e",
    #             "children": []
    #         })

    #         for topic in subcourse.topics.all():
    #             topic_data = get_or_create_node(unique_topics, topic.id, {
    #                 "id": f"topic_{topic.id}",
    #                 "background-color": "#ffc107",
    #                 "topic": f'<a target="_blank" href="{topic.url}">{topic.name}</a>',
    #                 "href": topic.url,
    #                 "data-target": None
    #             })

    #             if topic_data not in subcourse_data["children"]:
    #                 subcourse_data["children"].append(topic_data)

    #         if subcourse_data not in course_data["children"]:
    #             course_data["children"].append(subcourse_data)

    #     if course_data not in mindmap_data["data"]["children"]:
    #         mindmap_data["data"]["children"].append(course_data)

    # return JsonResponse(mindmap_data)



    institute = get_object_or_404(Institute, slug=institute_slug)
    
    data = {
        "nodes": [],
        "links": []
    }

    # Add institute node
    data["nodes"].append({
        "id": f"i-{institute.slug}",
        "name": institute.name,
        "type": "institute",
        "size": 45
    })
    
    for course in institute.courses.all():
        course_id = f"c-{course.slug}"
        data["nodes"].append({
            "id": course_id,
            "name": course.name,
            "type": "course",
            "size": 30
        })
        data["links"].append({
            "source": f"i-{institute.slug}",
            "target": course_id
        })

        for subcourse in course.subcourses.all():
            subcourse_id = f"s-{subcourse.slug}"
            data["nodes"].append({
                "id": subcourse_id,
                "name": subcourse.name,
                "type": "subcourse",
                "size": 20
            })
            data["links"].append({
                "source": course_id,
                "target": subcourse_id
            })

            for topic in subcourse.topics.all():
                topic_id = f"t-{topic.slug}"
                data["nodes"].append({
                    "id": topic_id,
                    "name": topic.name,
                    "type": "topic",
                    "size": 10
                })
                data["links"].append({
                    "source": subcourse_id,
                    "target": topic_id
                })
    # print("DATA:", data)

    return JsonResponse(data)

def node_map(request, institute_slug):
    institute = get_object_or_404(Institute, slug=institute_slug)
    return render(request, 'node_map.html', {'institute': institute})



from .serializers import InstituteSerializer
@login_required
def get_roadmap_data(request, institute_slug):
    institute = get_object_or_404(Institute, slug=institute_slug)
    serializer = InstituteSerializer(institute)
    serialized_data = serializer.data
    user_id = request.user.id
    gojs_data = transform_to_gojs(serialized_data, user_id)
    
    return JsonResponse(gojs_data)
def transform_to_gojs(data, user_id):
    nodes = []
    links = []
    user = User.objects.get(id=user_id)
    
    institute_key = f"i-{data['slug']}"
    nodes.append({
        "key": institute_key,
        "name": data['name'],
        "title": "Institute",
        "comments": data['description'],
        "progress": True,
        "isStartNode": True
    })
    
    for course in data['courses']:
        course_key = f"c-{course['slug']}"
        nodes.append({
            "key": course_key,
            "name": course['name'],
            "title": "Course",
            "comments": course['description'],
        })
        
        # Add Qualifying Tests before the course
        if course.get('tests_required'):
            for test in course['tests_required']:
                test_key = f"qt-{test['slug']}"
                nodes.append({
                    "key": test_key,
                    "name": test['name'],
                    "title": "Qualifying Test",
                    "comments": test['description'],
                })
                links.append({
                    "from": institute_key,
                    "to": test_key,
                    "text": "Take Test",
                    "key": f"link-{institute_key}-{test_key}",
                    "url": f"/take_test/{test['slug']}/"
                })
                links.append({
                    "from": test_key,
                    "to": course_key,
                    "text": "Pass Test",
                    "key": f"link-{test_key}-{course_key}",
                    "url": f"/pass_test/{test['slug']}/"
                })
        else:
            links.append({
                "from": institute_key,
                "to": course_key,
                "text": "Start",
                "key": f"link-{institute_key}-{course_key}"
            })
        
        prev_subcourse_key = course_key
        for subcourse in course['subcourses']:
            subcourse_key = f"s-{subcourse['slug']}"
            nodes.append({
                "key": subcourse_key,
                "name": subcourse['name'],
                "title": "SubCourse",
                "comments": subcourse['description'],
            })
            
            # Add Assessment before the subcourse
            if subcourse.get('prerequisite_assessment'):
                assessment = subcourse['prerequisite_assessment']
                assessment_key = f"as-{assessment['slug']}"
                nodes.append({
                    "key": assessment_key,
                    "name": assessment['name'],
                    "title": "Assessment",
                    "comments": assessment['description'],
                })
                links.append({
                    "from": prev_subcourse_key,
                    "to": assessment_key,
                    "text": "Take Assessment",
                    "key": f"link-{prev_subcourse_key}-{assessment_key}",
                    "url": f"/take_assessment/{assessment['slug']}/"
                })
                links.append({
                    "from": assessment_key,
                    "to": subcourse_key,
                    "text": "Pass Assessment",
                    "key": f"link-{assessment_key}-{subcourse_key}",
                    "url": f"/pass_assessment/{assessment['slug']}/"
                })
            else:
                links.append({
                    "from": prev_subcourse_key,
                    "to": subcourse_key,
                    "text": "Next",
                    "key": f"link-{prev_subcourse_key}-{subcourse_key}"
                })
            
            prev_topic_key = subcourse_key
            for topic in subcourse['topics']:
                topic_key = f"t-{topic['slug']}"
                nodes.append({
                    "key": topic_key,
                    "name": topic['name'],
                    "title": "Topic",
                    "comments": topic['description'],
                    "url": topic['url'],
                })
                
                # Add Assignment before the topic
                if topic.get('prerequisite_assignment'):
                    assignment = topic['prerequisite_assignment']
                    assignment_key = f"a-{assignment['slug']}"
                    nodes.append({
                        "key": assignment_key,
                        "name": assignment['name'],
                        "title": "Assignment",
                        "comments": assignment['description'],
                    })
                    links.append({
                        "from": prev_topic_key,
                        "to": assignment_key,
                        "text": "Do Assignment",
                        "key": f"link-{prev_topic_key}-{assignment_key}",
                        "url": f"/do_assignment/{assignment['slug']}/"
                    })
                    links.append({
                        "from": assignment_key,
                        "to": topic_key,
                        "text": "Complete Assignment",
                        "key": f"link-{assignment_key}-{topic_key}",
                        "url": f"/complete_assignment/{assignment['slug']}/"
                    })
                else:
                    links.append({
                        "from": prev_topic_key,
                        "to": topic_key,
                        "text": "Next",
                        "key": f"link-{prev_topic_key}-{topic_key}"
                    })
                
                prev_topic_key = topic_key
            
            prev_subcourse_key = subcourse_key

    return {"class": "GraphLinksModel", "nodeDataArray": nodes, "linkDataArray": links}

@login_required
def roadmap(request, institute_slug):
    context = {'institute_slug': institute_slug}
    return render(request, 'roadmap.html', context)


from django.shortcuts import render

def take_test(request, test_slug):
    
    return render(request, 'test.html', {'test_slug': test_slug})

def pass_test(request, test_slug):
    
    return render(request, 'pass_test.html', {'test_slug': test_slug})

def take_assessment(request, assessment_slug):
    
    return render(request, 'assessment.html', {'assessment_slug': assessment_slug})

def pass_assessment(request, assessment_slug):
    
    return render(request, 'pass_assessment.html', {'assessment_slug': assessment_slug})

def do_assignment(request, assignment_slug):
    
    return render(request, 'assignment.html', {'assignment_slug': assignment_slug})

def complete_assignment(request, assignment_slug):
    
    return render(request, 'complete_assignment.html', {'assignment_slug': assignment_slug})
