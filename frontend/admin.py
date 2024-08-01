from django.contrib import admin
from .models import Institute, Course, SubCourse, Topic, CourseRoom, TestRequirement, Assessment, Assignment, UserProgress, QualifyingTest
# Register your models here.
admin.site.register(CourseRoom)
admin.site.register(TestRequirement)
admin.site.register(Assessment)
admin.site.register(Assignment)
admin.site.register(QualifyingTest)

@admin.register(Institute)
class InstituteAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')

@admin.register(Course)
class CourseAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')
    filter_horizontal = ('institutes',)  # To display a widget for selecting multiple institutes

@admin.register(SubCourse)
class SubCourseAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')
    filter_horizontal = [] #('courses',)  # To display a widget for selecting multiple courses

@admin.register(Topic)
class TopicAdmin(admin.ModelAdmin):
    list_display = ('name', 'subcourse', 'description', 'url')

@admin.register(UserProgress)
class UserProgressAdmin(admin.ModelAdmin):
    list_display = ('user', 'get_institutes', 'get_courses', 'get_subcourses', 'get_topics', 'get_tests_completed', 'get_assessments_completed', 'get_assignments_completed')
    filter_horizontal = ('institutes','courses', 'subcourses', 'topics',  'assessments_completed', 'assignments_completed')

    def get_institutes(self, obj):
        return ", ".join([institute.name for institute in obj.institutes.all()])

    def get_courses(self, obj):
        return ", ".join([course.name for course in obj.courses.all()])

    def get_subcourses(self, obj):
        return ", ".join([subcourse.name for subcourse in obj.subcourses.all()])

    def get_topics(self, obj):
        return ", ".join([topic.name for topic in obj.topics.all()])

    def get_tests_completed(self, obj):
        return ", ".join([test.name for test in obj.tests_completed.all()])

    def get_assessments_completed(self, obj):
        return ", ".join([assessment.name for assessment in obj.assessments_completed.all()])
    
    def get_assignments_completed(self, obj):
        return ", ".join([assignment.name for assignment in obj.assignments_completed.all()])

    # Custom column names for better readability
    get_institutes.short_description = 'Institutes'
    get_courses.short_description = 'Courses'
    get_subcourses.short_description = 'Subcourses'
    get_topics.short_description = 'Topics'
    get_tests_completed.short_description = 'Tests Completed'
    get_assessments_completed.short_description = 'Assessments Completed'
    get_assignments_completed.short_description = 'Assessments Completed'