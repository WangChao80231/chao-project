package ${package.Service};

import ${package.Entity}.${entity};
import ${package.Entity}.dto.${entitySaveDto};
import ${package.Entity}.dto.${entityUpdateDto};
import ${package.Entity}.dto.${entityQryDto};
import ${package.Entity}.vo.${entityVo};
import ${superServiceClassPackage};
import com.baomidou.mybatisplus.core.metadata.IPage;

/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if kotlin>
interface ${table.serviceName} : ${superServiceClass}<${entity}>
<#else>
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {

    /**
     * 查询${table.comment!}分页数据
     *
    * @param ${entityQryDto?uncap_first} ${table.comment!}查询Dto
     * @return IPage<${entityVo}>
     */
    IPage<${entityVo}> listPage(${entityQryDto} ${entityQryDto?uncap_first});

    /**
    * id查询数据
    *
    * @param id id
    * @return ${entityVo}
    */
    ${entityVo} getDetailById(Long id);

    /**
     * 添加${table.comment!}
     *
     * @param ${entitySaveDto?uncap_first} ${table.comment!}保存Dto
     */
    Long add(${entitySaveDto} ${entitySaveDto?uncap_first});

    /**
    * 修改${table.comment!}
    *
    * @param ${entityUpdateDto?uncap_first} ${table.comment!}更新Dto
    */
    void update(${entityUpdateDto} ${entityUpdateDto?uncap_first});

    /**
     * 删除${table.comment!}
     *
     * @param id 主键
     */
    void delete(Long id);




}
</#if>
