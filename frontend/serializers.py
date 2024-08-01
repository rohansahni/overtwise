from rest_framework import serializers
from .models import Institute, Course, SubCourse, Topic, UserProgress, Assessment, Assignment, CourseRoom, TestRequirement

class TestRequirementSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestRequirement
        fields = ['name', 'slug', 'description', 'from_course', 'to_course']

class AssignmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assignment
        fields = ['name', 'slug', 'description']

class AssessmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assessment
        fields = ['name', 'slug', 'description']

class TopicSerializer(serializers.ModelSerializer):
    prerequisite_assignment = AssignmentSerializer(read_only=True)

    class Meta:
        model = Topic
        fields = ['name', 'slug', 'description', 'url', 'prerequisite_assignment']

class SubCourseSerializer(serializers.ModelSerializer):
    topics = TopicSerializer(many=True, read_only=True)
    prerequisite_assessment = AssessmentSerializer(read_only=True)

    class Meta:
        model = SubCourse
        fields = ['name', 'slug', 'description', 'topics', 'prerequisite_assessment']

class CourseSerializer(serializers.ModelSerializer):
    subcourses = SubCourseSerializer(many=True, read_only=True)
    tests_required = TestRequirementSerializer(many=True, read_only=True)
    
    class Meta:
        model = Course
        fields = ['name', 'slug', 'description', 'subcourses', 'tests_required']


class InstituteSerializer(serializers.ModelSerializer):
    courses = CourseSerializer(many=True, read_only=True)
    
    class Meta:
        model = Institute
        fields = ['name', 'slug', 'description', 'logo', 'courses']

class UserProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProgress
        fields = '__all__'

class CourseRoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = CourseRoom
        fields = ['name', 'description', 'members']
