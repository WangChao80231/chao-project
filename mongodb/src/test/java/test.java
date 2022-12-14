import com.mongodb.Main;
import com.mongodb.client.result.UpdateResult;
import com.mongodb.dao.StudentDao;
import com.mongodb.entity.Student;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.Part;
import java.util.List;
import java.util.regex.Pattern;

/**
 * <p>
 *  TODO
 * </p>
 *
 * @author wangchao
 * @date 2022/12/13 13:08
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Main.class)
public class test {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Test
    public void insert(){
        Student student = new Student();
        student.setId(1L);
        student.setUsername("chao1");
        mongoTemplate.insert(student);
    }

    @Test
    public void selectOne(){
        Student student = new Student();
        student.setId(2L);
        student.setUsername("chao");
        Query query = new Query(Criteria.where("_id").is(student.getId()));

        // 根据id查询
        Student one = mongoTemplate.findOne(query, Student.class);
        System.out.println(one);

        // 根据学生姓名查询
        Query query2 = new Query(Criteria.where("username").is(student.getUsername()));
        List<Student> students = mongoTemplate.find(query2, Student.class);
        System.out.println(students);

        // 模糊查询
        Pattern compile = Pattern.compile("^.*" + student.getUsername() + ".*$", Pattern.CASE_INSENSITIVE);
        Query query1 = new Query(Criteria.where("username").regex(compile));
        List<Student> students1 = mongoTemplate.find(query1, Student.class);
        System.out.println("like"+ students1);

        // 排序
        Query query3 = new Query();
         query3.with(Sort.by(Sort.Direction.ASC,"_id"));
        List<Student> students2 = mongoTemplate.find(query3, Student.class);
        System.out.println("sort"+ students2);
    }

    @Test
    public void update(){
        Student student1 = new Student();
        student1.setId(1L);
        student1.setUsername("chao1");
        Query query = new Query(Criteria.where("_id").is(student1.getId()));
        Update update = new Update().set("username", student1.getUsername());
        mongoTemplate.updateFirst(query, update, Student.class);
    }

    @Test
    public void del(){
        Student student1 = new Student();
        student1.setId(1L);
        Query query = new Query(Criteria.where("_id").is(student1.getId()));
        mongoTemplate.remove(query,  Student.class);
    }

    @Autowired
    private StudentDao studentDao;

    @GetMapping("selectByDao")
    public void selectByDao(){
        List<Student> chao = studentDao.getByUsername("chao");
        System.out.println(chao);
    }
}
