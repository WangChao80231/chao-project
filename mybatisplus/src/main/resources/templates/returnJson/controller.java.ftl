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
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
<#--</#if>@RequestMapping("/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")-->
</#if>@RequestMapping("/${table.entityPath}")
<#if kotlin>class ${table.controllerName}<#if superControllerClass??>:${superControllerClass}()</#if><#else><#if superControllerClass??>public class ${table.controllerName} extends ${superControllerClass}{<#else>public class ${table.controllerName} {</#if>

    @Autowired
    private ${table.serviceName} ${(table.serviceName?substring(1))?uncap_first};


    @ApiOperation(value = "查询${table.comment!}分页数据")
    @PostMapping("listPage")
    public JsonForResult listPage(@ApiParam("${table.comment!}查询Dto") @RequestBody ${entityQryDto} ${entityQryDto?uncap_first}){
        IPage<${entityVo}> page = ${(table.serviceName?substring(1))?uncap_first}.listPage(${entityQryDto?uncap_first});
        return JsonForResult.<List<${entityVo}>>builder().total((int) page.getTotal()).success(true).data(page.getRecords()).build();
    }

    @ApiOperation(value = "id查询${table.comment!}")
    @GetMapping("getById/{id}")
    public JsonForResult<${entityVo}> getById(@ApiParam("${table.comment!}id") @PathVariable Long id){
        ${entityVo} ${entityVo?uncap_first} = ${(table.serviceName?substring(1))?uncap_first}.getDetailById(id);
        return JsonForResult.<${entityVo}>builder().success(true).data(${entityVo?uncap_first} ).build();
    }

    @ApiOperation(value = "新增${table.comment!}")
    @PostMapping("add")
    public JsonForResult<Long> add(@ApiParam("${table.comment!}新增Dto") @RequestBody ${entitySaveDto} ${entitySaveDto?uncap_first}){
        Long id = ${(table.serviceName?substring(1))?uncap_first}.add(${entitySaveDto?uncap_first});
        return JsonForResult.<Long>builder().success(true).data(id).build();
    }

    @ApiOperation(value = "修改${table.comment!}")
    @PostMapping("update")
    public JsonForResult<String> update(@ApiParam("${table.comment!}修改Dto") @RequestBody ${entityUpdateDto} ${entityUpdateDto?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.update(${entityUpdateDto?uncap_first});
        return JsonForResult.<String>builder().success(true).data("修改成功").build();
    }

    @ApiOperation(value = "删除${table.comment!}")
    @DeleteMapping("del/{id}")
    public JsonForResult delete(@ApiParam("${table.comment!}id") @PathVariable("id") Long id){
        ${(table.serviceName?substring(1))?uncap_first}.delete(id);
        return JsonForResult.<String>builder().success(true).data("删除成功").build();
    }


}
</#if>