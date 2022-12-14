package ${package.Controller};

import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import ${package.Service}.${table.serviceName};
import ${package.Entity}.dto.${entitySaveDto};
import ${package.Entity}.dto.${entityUpdateDto};
import ${package.Entity}.dto.${entityQryDto};
import ${package.Entity}.vo.${entityVo};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.baomidou.mybatisplus.core.metadata.IPage;

import javax.annotation.Resource;
<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@Api(tags = {"${table.comment!}"})
@RestController
<#else>
@Controller
<#--</#if>@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")-->
</#if>@RequestMapping("/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>class ${table.controllerName}<#if superControllerClass??>:${superControllerClass}()</#if><#else><#if superControllerClass??>public class ${table.controllerName} extends ${superControllerClass}{<#else>public class ${table.controllerName} {</#if>

    @Resource
    private ${table.serviceName} ${(table.serviceName?substring(1))?uncap_first};


    @ApiOperation(value = "查询${table.comment!}分页数据")
    @GetMapping("listPage")
    public Object listPage(@ApiParam("${table.comment!}查询Dto") @RequestBody ${entityQryDto} ${entityQryDto?uncap_first}){
        IPage<${entityVo}> page = ${(table.serviceName?substring(1))?uncap_first}.listPage(${entityQryDto?uncap_first});
        return null;
    }

    @ApiOperation(value = "id查询${table.comment!}")
    @GetMapping("getById/{id}")
    public Object getById(@ApiParam("${table.comment!}id") @PathVariable Long id){
        ${entityVo} ${entityVo?uncap_first} = ${(table.serviceName?substring(1))?uncap_first}.getDetailById(id);
        return null;
    }

    @ApiOperation(value = "新增${table.comment!}")
    @PostMapping("add")
    public Object add(@ApiParam("${table.comment!}新增Dto") @RequestBody ${entitySaveDto} ${entitySaveDto?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.add(${entitySaveDto?uncap_first});
        return "新增成功";
    }

    @ApiOperation(value = "修改${table.comment!}")
    @PostMapping("update")
    public Object update(@ApiParam("${table.comment!}修改Dto") @RequestBody ${entityUpdateDto} ${entityUpdateDto?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.update(${entityUpdateDto?uncap_first});
        return "修改成功";
    }

    @ApiOperation(value = "删除${table.comment!}")
    @DeleteMapping("del/{id}")
    public Object delete(@ApiParam("${table.comment!}id") @PathVariable("id") Long id){
        ${(table.serviceName?substring(1))?uncap_first}.delete(id);
        return "删除成功";
    }


}
</#if>