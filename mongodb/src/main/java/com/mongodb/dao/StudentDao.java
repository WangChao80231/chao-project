package com.mongodb.dao;

import com.mongodb.entity.Student;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  TODO
 * </p>
 *
 * @author wangchao
 * @date 2022/12/13 14:47
 */
public interface StudentDao extends MongoRepository<Student,Long> {

    List<Student> getByUsername(String username);

    Student getById(Long id);
}
