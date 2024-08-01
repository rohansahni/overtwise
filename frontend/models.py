
# Create your models here.
from django.db import models
from django.utils.text import slugify
# models.py
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None):
        if not email:
            raise ValueError("Email address is required.")
        user = self.model(email=self.normalize_email(email))
        user.set_password(password)
        user.save(using=self._db)
        return user

class CustomUser(AbstractBaseUser):
    email = models.EmailField(unique=True)
    # Add other fields as needed (e.g., first_name, last_name, etc.)
    # ...

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    # Add other required fields (e.g., REQUIRED_FIELDS = ['first_name', 'last_name'])

    def __str__(self):
        return self.email




class Institute(models.Model):
    name = models.CharField(max_length=255, unique=True)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    description = models.TextField(blank=True)
    logo = models.ImageField(upload_to='institute_logos/', blank=True, null=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name



class QualifyingTest(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    description = models.TextField(blank=True)
    

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name
    

class Course(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    institutes = models.ManyToManyField(Institute, related_name='courses')
    description = models.TextField(blank=True)
    qualifying_test = models.ForeignKey(QualifyingTest, on_delete=models.SET_NULL, null=True, blank=True, related_name='courses')

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name



class Assessment(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    description = models.TextField(blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name
    


class SubCourse(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    course = models.ForeignKey(Course, related_name='subcourses', on_delete=models.CASCADE)
    description = models.TextField(blank=True)
    prerequisite_assessment = models.ForeignKey(Assessment, on_delete=models.SET_NULL, null=True, blank=True, related_name='next_subcourses')
    order = models.PositiveIntegerField(default=0)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['course', 'order']



class Assignment(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    description = models.TextField(blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class Topic(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True, blank=True)
    subcourse = models.ForeignKey(SubCourse, related_name='topics', on_delete=models.CASCADE)
    description = models.TextField(blank=True)
    url = models.URLField(blank=True)
    prerequisite_assignment = models.ForeignKey(Assignment, on_delete=models.SET_NULL, null=True, blank=True, related_name='next_topics')
    order = models.PositiveIntegerField(default=0)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.subcourse.name} - {self.name}"

    class Meta:
        ordering = ['subcourse', 'order']
    


from django.contrib.auth.models import User
class TestRequirement(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True)
    description = models.TextField(blank=True)
    from_course = models.ForeignKey(Course, related_name='tests_required', on_delete=models.CASCADE)
    to_course = models.ForeignKey(Course, related_name='tests_prerequisite', on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.name} (from {self.from_course} to {self.to_course})"
    

class UserProgress(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    institutes = models.ManyToManyField(Institute, related_name='user_progress_institute', blank=True)
    courses = models.ManyToManyField(Course, related_name='user_progress_course', blank=True)
    subcourses = models.ManyToManyField(SubCourse, related_name='user_progress_subcourse', blank=True)
    topics = models.ManyToManyField(Topic, related_name='user_progress_topic', blank=True)
    qualifying_tests_completed = models.ManyToManyField(QualifyingTest, related_name='user_progress_tests', blank=True)
    assessments_completed = models.ManyToManyField(Assessment, related_name='user_progress_assessments', blank=True)
    assignments_completed = models.ManyToManyField(Assignment, related_name='user_progress_assignments', blank=True)

    def __str__(self):
        return f"UserProgress for {self.user.email}"


class CourseRoom(models.Model):
    course = models.OneToOneField(Course, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    members = models.ManyToManyField(CustomUser, related_name='course_rooms')

    def __str__(self):
        return f"CourseRoom for {self.course.name}"