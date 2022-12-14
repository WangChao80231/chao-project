package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
import ${package.Entity}.vo.${entityVo};
import ${package.Entity}.dto.${entityQryDto};
<#if mapperAnnotationClass??>
import ${mapperAnnotationClass.name};
</#if>

import java.util.List;

/**
 * <p>
 * ${table.comment!} Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if mapperAnnotationClass??>
@${mapperAnnotationClass.simpleName}
</#if>
<#if kotlin>
interface ${table.mapperName} : ${superMapperClass}<${entity}>
<#else>
public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {

   /**
   * ${table.comment!}分页数据
   *
   * @param ${entityQryDto?uncap_first} ${table.comment!}查询Dto
   * @return IList<${entityVo}>
   */
   List<${entityVo}> getListPage(${entityQryDto} ${entityQryDto?uncap_first});

   /**
   * ${table.comment!}总数
   *
   * @param ${entityQryDto?uncap_first} ${table.comment!}查询Dto
   * @return int
   */
   int getListPageCount(${entityQryDto} ${entityQryDto?uncap_first});
}
</#if>
