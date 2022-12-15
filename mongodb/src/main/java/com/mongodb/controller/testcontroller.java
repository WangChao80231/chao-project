package com.mongodb.controller;

import com.alibaba.fastjson2.JSONObject;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.mongodb.dao.StudentDao;
import com.mongodb.entity.Grade;
import com.mongodb.entity.Student;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.aggregation.ProjectionOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

/**
 * <p>
 *  TODO
 * </p>
 *
 * @author wangchao
 * @date 2022/12/13 11:34
 */

@RestController()
public class testcontroller {
    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private StudentDao studentDao;

    @GetMapping("insert")
    public void insert(){
        Student student = new Student();
        student.setId(1L);
        student.setUsername("chao");
        mongoTemplate.insert(student);

//        Grade grade = new Grade();
//        grade.setId(3L);
//        grade.setClas("语文");
//        grade.setScore(12D);
//        grade.setStudentId(1L);
//        Grade grade2 = new Grade();
//        grade2.setId(2L);
//        grade2.setClas("语文");
//        grade2.setScore(12D);
//        grade2.setStudentId(2L);
//        List<Grade> grades = Arrays.asList(grade, grade2);
//        mongoTemplate.save(grade2);
        mongoTemplate.save(student);
    }

    @GetMapping("select")
    public void select(){
        Student student = new Student();
        student.setId(2L);
        student.setUsername("chao");

        Query query;
        query = new Query();
//        query = new Query(Criteria.where("_id").is(student.getId()));
        // 根据id查询
        Student one = mongoTemplate.findOne(query, Student.class);
        System.out.println("根据id查询:"+ one);

        // 根据学生姓名查询
        query= new Query(Criteria.where("username").is(student.getUsername()));
        List<Student> students = mongoTemplate.find(query, Student.class);
        System.out.println("根据学生姓名查询:" + students);

        // 模糊查询
        Pattern compile = Pattern.compile("^.*" + student.getUsername() + ".*$", Pattern.CASE_INSENSITIVE);
        query = new Query(Criteria.where("username").regex(compile));
        List<Student> students1 = mongoTemplate.find(query, Student.class);
        System.out.println("模糊查询:"+ students1);

        // 排序
        query = new Query();
        query.with(Sort.by(Sort.Direction.ASC,"_id"));
        List<Student> students2 = mongoTemplate.find(query, Student.class);
        System.out.println("排序:"+ students2);

        // 分页查询
        Sort sort = Sort.by(Sort.Direction.ASC, "_id");
        query = new Query();
        query.with(PageRequest.of(1,1,sort));
        List<Student> ts = mongoTemplate.find(query, Student.class);
        System.out.println("分页查询:" + ts);
//
//        Aggregation aggregation = Aggregation.newAggregation();
//        mongoTemplate.aggregate();
//        mongoTemplate.mapReduce()
    }

    /**
     * 多表联查
     */
    @GetMapping("joinSelect")
    public void joinSelect(){
        LookupOperation lookupOperation = LookupOperation.newLookup()
                .from("grade")    //1.副表表名字
                .localField("_id")//2.主表的关联字段
                .foreignField("studentId")//3.副表的关联字段
                .as("stu_grade");; //4.建议和1一致，结果的别名
        //

        //1.关联多张表就写多个     2.多表的关联条件，查询条件均传入到此
        /*LookupOperation lookupOperation2 = LookupOperation.newLookup();
         Aggregation aggregation = Aggregation.newAggregation(
                             lookupOperation,
                        lookupOperation2,
                        Aggregation.match(Criteria.where("_id").lte(2)),
                          //5.此作用处下文解释
                        Aggregation.unwind("adrs"),
                        //筛选条件，筛选主表的字段直接写，副表则是'别名.字段名'
                        Aggregation.match(Criteria.where("adrs.adrsId").is(1))
                );*/
        /*
          *  AggregationOperation  是一个操作父类，很多操作都可以查看这个的继承类
         */

        // 选择查询列 或者重命名
/*        ProjectionOperation project = Aggregation.project("_id","name","price")
                .and("merchant_as.name").as("merchantName");
        Aggregation aggregation = Aggregation.newAggregation(lookupOperation,project);*/

        Aggregation aggregation = Aggregation.newAggregation(lookupOperation);
        // 将一对多的数组和主表的数据匹配，相当于以子表为主，进行左联接
//        Aggregation aggregation = Aggregation.newAggregation(lookupOperation,Aggregation.unwind("stu_grade",false));
        AggregationResults<JSONObject> student = mongoTemplate.aggregate(aggregation, "student", JSONObject.class);
        System.out.println("student:" + student.getMappedResults());
    }

    // TODO-wangChao 2022/12/15 10:54  mapReduce代做
    //        mongoTemplate.mapReduce()


    @GetMapping("update")
    public void update(){
        Student student1 = new Student();
        student1.setId(1L);
        student1.setUsername("chao1");
        Query query = new Query(Criteria.where("_id").is(student1.getId()));
        Update update = new Update().set("username", student1.getUsername());
        mongoTemplate.updateFirst(query, update, Student.class);
    }

    @GetMapping("del")
    public void del(){
        Student student1 = new Student();
        student1.setId(1L);
        Query query = new Query(Criteria.where("_id").is(student1.getId()));
        mongoTemplate.remove(query,  Student.class);
    }

}
