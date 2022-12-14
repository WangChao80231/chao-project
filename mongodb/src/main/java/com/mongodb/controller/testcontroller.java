package com.mongodb.controller;

import com.mongodb.dao.StudentDao;
import com.mongodb.entity.Student;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

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
    }

    @GetMapping("select")
    public void select(){
        Student student = new Student();
        student.setId(2L);
        student.setUsername("chao");

        Query query;
        query = new Query(Criteria.where("_id").is(student.getId()));
        // 根据id查询
        Student one = mongoTemplate.findOne(query, Student.class);
        System.out.println(one);

        // 根据学生姓名查询
        query= new Query(Criteria.where("username").is(student.getUsername()));
        List<Student> students = mongoTemplate.find(query, Student.class);
        System.out.println(students);

        // 模糊查询
        Pattern compile = Pattern.compile("^.*" + student.getUsername() + ".*$", Pattern.CASE_INSENSITIVE);
        query = new Query(Criteria.where("username").regex(compile));
        List<Student> students1 = mongoTemplate.find(query, Student.class);
        System.out.println("like"+ students1);

        // 排序
        query = new Query();
        query.with(Sort.by(Sort.Direction.ASC,"_id"));
        List<Student> students2 = mongoTemplate.find(query, Student.class);
        System.out.println("sort"+ students2);

        // 分页查询
        Sort sort = Sort.by(Sort.Direction.ASC, "_id");
        query = new Query();
        query.with(PageRequest.of(1,1,sort));
        List<Student> ts = (List<Student>) mongoTemplate.find(query, Student.class);
        System.out.println(ts);
    }


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


    @GetMapping("listPage")
    public void listPage() {

    }
}
