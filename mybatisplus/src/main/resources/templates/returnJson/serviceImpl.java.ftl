package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Entity}.dto.${entitySaveDto};
import ${package.Entity}.dto.${entityUpdateDto};
import ${package.Entity}.dto.${entityQryDto};
import ${package.Entity}.vo.${entityVo};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import com.maqh.demo.util.BeanConvertUtils;
import com.baomidou.mybatisplus.core.toolkit.Assert;

/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
<#if kotlin>
open class ${table.serviceImplName} : ${superServiceImplClass}<${table.mapperName}, ${entity}>(), ${table.serviceName} {

}
<#else>
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {

    @SuppressWarnings("all")
    @Override
    public IPage<${entityVo}> listPage( ${entityQryDto} ${entityQryDto?uncap_first}){
        IPage page = this.lambdaQuery().page(new Page<>(1, 10));
        List<${entityVo}> list =  BeanConvertUtils.convertListTo(page.getRecords(),${entityVo}::new);
        page.setRecords(list);
        return page;
    }

    @Override
    public ${entityVo} getDetailById(Long id){
        ${entity} ${entity?uncap_first} = this.getById(id);
        Assert.notNull(${entity?uncap_first} ,"详情不存在！");
        return BeanConvertUtils.convertTo(${entity?uncap_first} ,${entityVo}::new);
    }

    @Override
    public void add(${entitySaveDto} ${entitySaveDto?uncap_first}){
        ${entity} ${entity?uncap_first} =  BeanConvertUtils.convertTo(${entitySaveDto?uncap_first},${entity}::new);
        this.save(${entity?uncap_first});
    }

    @Override
    public void update(${entityUpdateDto} ${entityUpdateDto?uncap_first}){
        ${entity} ${entity?uncap_first} =  BeanConvertUtils.convertTo(${entityUpdateDto?uncap_first},${entity}::new);
        this.updateById(${entity?uncap_first});
    }

    @Override
    public void delete(Long id){
        this.removeById(id);
    }


}
</#if>
