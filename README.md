![image](https://github.com/user-attachments/assets/542900e4-61a2-44a7-895e-6e6ba79dab43)
## Problem Statement: 
- Skilling : With rapid technological change, there is a growing disparity between the skills youth
possess and those required by the job market. Unequal access to skilling opportunities exacerbates this issue.
Furthermore, gender inequality and the lack of accessible training for disabled individuals deepen these gaps, limiting
opportunities for many. Tackling these problems is essential for creating a fair and inclusive job market.

##
### OVERTWISE
Every student aspires to receive a high-quality education from top-tier colleges, but only a small fraction actually secures admission to these prestigious institutions. For instance, the IITs admit just 0.08% of applicants. Unfortunately, in our country, access to excellent education remains limited for the majority of students. Amid this scarcity, there exist only a few ‘islands of excellence’ amidst a vast ocean of mediocrity. Additionally, academic freedom is often lacking.
In today’s rapidly evolving job market, there’s a notable skills gap between what young people 
possess and what employers seek. This gap is further widened by the lack of accessible training and 
unequal access to quality education. These challenges create a system where many talented 
individuals are left behind, unable to reach their full potential. It’s no coincidence that most students 
from top institutes like IIMs and IITs rarely fail in life. The quality education and exposure they receive 
prepare them comprehensively for life’s challenges. 



## Table of Contents
* Introduction
* Installation
* Usage
* Features
* Contributing
* License

## Introduction
Inspired by successful online platforms like Roadmap.sh, The Odin Project (TOP), Coursera, and edX, as well as the quality education provided by top-tier institutes, our application, OvertWise, aims to blend the structured learning of traditional academia with the flexibility and accessibility of online education. Drawing from the innovations in online university programs, our app provides a well-organized, engaging, and graded learning experience. It encourages learners to set clear, meaningful goals—whether it’s mastering coding, delving into physics, exploring neuroscience, or any other subject. We are here to provide a real classroom experience with online top resources.

## Installation
1. Clone this repository: 
   `
   git clone https://github.com/rohansahni/overtwise.git
    cd overtwise
`
2. Install dependencies: 
   `pip install -r requirements.txt`
3. Set up your database:
   `python manage.py migrate
`
4. Run the development server:
   `python manage.py runserver
`

## Usage
Visit `http://localhost:8000/` in your browser to explore OvertWise.


## Features
- Institute Exploration: Students can explore various institutes and their offerings. Each institute has a unique knowledge web, detailing the available programs and courses.
- Structured Learning Path: Courses, Sub-Courses, and Topics are organized hierarchically. To advance, students must complete assessments at various stages, mimicking the rigorous structure of offline institutions.
- Qualifying Tests: Before starting a course, students must pass a qualifying test. This ensures readiness and commitment, similar to entrance exams in traditional education systems.
- Sub-Course Assessments: Students must complete assessments to advance from one sub-course to another. These assessments evaluate understanding and mastery of the sub-course content.
- Topic Assignments: To progress through topics within a sub-course, students must complete assignments. These assignments reinforce learning and ensure students are keeping up with the coursework.
- Progress Tracking: Students can track their progress through the roadmap of their chosen institute. Visual indicators show completed and pending assessments, assignments, and qualifying tests.
- Community Engagement: The platform fosters a sense of community akin to a traditional classroom. Students can interact, discuss, and collaborate, enhancing their learning experience.


## Contributing
Contributions are welcome! If you’d like to improve OvertWise, follow these steps:
1. Fork the repository.
2. Create a new branch: git checkout -b my-feature.
3. Make your changes and commit: git commit -m "Add my feature".
4. Push to your fork: git push origin my-feature.
5. Create a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
