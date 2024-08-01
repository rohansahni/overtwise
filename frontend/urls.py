from django.urls import path, re_path
from . import views

urlpatterns = [
    path('', views.dashboard, name='home'),  # Example: Root URL
    path('signup/', views.signup_view, name='signup'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('dashboard/', views.dashboard, name='dashboard'),  # Example: Root URL
    path('node_map/<slug:institute_slug>/', views.node_map, name='node_map'),
    path('get_institute_nodemap/<slug:institute_slug>/', views.get_institute_nodemap, name='get_institute_nodemap'),
    path('roadmap/<slug:institute_slug>/', views.roadmap, name='roadmap'),
    path('roadmap_data/<slug:institute_slug>/', views.get_roadmap_data, name='roadmap_data'),
    path('join_course_room/<slug:course_slug>/', views.join_course_room, name='join_course_room'),
    path('take_test/<slug:test_slug>/', views.take_test, name='take_test'),
    path('pass_test/<slug:test_slug>/', views.pass_test, name='pass_test'),
    path('take_assessment/<slug:assessment_slug>/', views.take_assessment, name='take_assessment'),
    path('pass_assessment/<slug:assessment_slug>/', views.pass_assessment, name='pass_assessment'),
    path('do_assignment/<slug:assignment_slug>/', views.do_assignment, name='do_assignment'),
    path('complete_assignment/<slug:assignment_slug>/', views.complete_assignment, name='complete_assignment'),
    # path('about/', views.about, name='about'),  # Example: /about/
    # path('university/', views.year_archive, name='year_archive'),  # Example: /articles/2023/
    # Add more patterns as needed
]
