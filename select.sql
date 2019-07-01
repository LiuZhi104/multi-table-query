# 1.查询同时存在1课程和2课程的情况
select student.* from student,student_course
where student.id=student_course.studentId and courseId=1
and exists
(select student.* from student,student_course
where student.id=student_course.studentId and courseId=2);
# 2.查询同时存在1课程和2课程的情况
select student.* from student,student_course
where student.id=student_course.studentId and courseId=1
and exists
(select student.* from student,student_course
where student.id=student_course.studentId and courseId=2);
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select
    t1.studentId,
    t2.name,
    avg(t1.score) as avg_score
from
    student_course t1
left join student t2 on
    t1.studentId = t2.id
group by
    t1.studentId
having
    avg(t1.score) >= 60
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select * from student
where student.id not in(
select st.id from student_course s,student st,course c where s.studentId=st.id and courseId=c.id and c.id=1
)
# 5.查询所有有成绩的SQL
select * from student
where student.id  in(
select st.id from student_course s,student st,course c where s.studentId=st.id and courseId=c.id and c.id=1
)
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select
    a.*
from
    student a,
   student_course b,
   student_course c
where
    a.id = b.studentId
    and a.id = c.studentId
    and b.courseId = '1'
    and c.courseId = '2';

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select
    t2.*
from
    student_course t1,
    student t2
where
    t2.id = t1.studentId
    and t1.score < '60'
    and t1.courseId = '1'
order by
    t1.score;
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select  student_course.courseId,AVG( student_course.score) from student_course GROUP BY
 student_course.courseId ORDER BY AVG( student_course.score) DESC , student_course.courseId ASC
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select student.name , score
from student , student_course , course
where student_course.studentId = student.id and student_course.courseId = course.id and course.name = '数学' and score < 60