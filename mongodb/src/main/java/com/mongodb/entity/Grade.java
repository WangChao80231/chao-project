package com.mongodb.entity;

import lombok.Data;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * <p>
 *  TODO
 * </p>
 *
 * @author wangchao
 * @date 2022/12/14 17:21
 */
@Data
@Document(collection = "grade")  //指定要对应的文档名(表名）
@ToString
public class Grade {
    @Id
    private Long id;
    private String clas;
    private Double score;
    private Long studentId;
}
