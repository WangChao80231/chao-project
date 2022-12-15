package com.mp;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.builder.CustomFile;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.baomidou.mybatisplus.generator.fill.Column;

import javax.validation.constraints.NotNull;
import java.io.File;
import java.util.*;

/**
 * @author maqh
 * @date 2019/9/6 16:41
 */
public class Generator {
//    final static String url = "jdbc:mysql://139.196.204.83:3306/phi-training?useUnicode=true&characterEncoding=utf8";
    final static String url = "jdbc:mysql://192.168.1.252/phi-training-copy?useUnicode=true&characterEncoding=utf8";
    final static String userName = "root";
//    final static String password = "Giga@163.com";
    final static String password = "PhiMysql!1234";
    final static String projectPath = "/Users/wangchao/my-project/chao-project/mybatisplus";
//    final static String projectPath = "/Users/wangchao/zq-project/phi-training";
    final static String parentPackage = "com.zigin.net.phi.training";
    final static String moduleName = "";

    public static void main(String[] args) {

        FastAutoGenerator.create(url, userName, password)
                .globalConfig(builder -> {
                    builder.author("wangchao") // 设置作者
                            .outputDir(projectPath + "/src/main/java")
                            .disableOpenDir()
                            .enableSwagger()
                            .fileOverride()
                            .build();
                })
                .packageConfig(builder -> {
                    builder.parent(parentPackage) // 设置父包名
                            .moduleName(moduleName) // 设置父包模块名
                            .service("service")
                            .controller("controller")
                            .serviceImpl("service.impl")
                            .pathInfo(Collections.singletonMap(OutputFile.xml, projectPath + "/src/main/resources/mapper"));
                })
                .strategyConfig(builder -> {
                    builder.addInclude(scanner("表名，多个英文逗号分割").split(",")) // 设置需要生成的表名
//                    builder.addInclude("project_progress_manage") // 设置需要生成的表名
                    .entityBuilder()
                            .enableLombok()
                            .enableChainModel()
                            .enableRemoveIsPrefix()
                            .logicDeleteColumnName("deleted")
                            .formatFileName("%s")
//                            .enableTableFieldAnnotation()
                            .enableActiveRecord()
                            .addTableFills(new Column("create_by", FieldFill.INSERT),new Column("update_by", FieldFill.UPDATE))

                            .controllerBuilder()
                            .enableRestStyle()
                            .formatFileName("%sController")
                            .serviceBuilder()
                            .formatServiceFileName("I%sService")
                            .formatServiceImplFileName("%sServiceImpl")
                            .mapperBuilder()
                            .enableBaseColumnList()
                            .enableBaseResultMap()
                            .formatMapperFileName("%sMapper")
                            .formatXmlFileName("%sMapper")
                            .build();
                })
                  .injectionConfig(builder->{
                        List<CustomFile> list = new ArrayList<>();
                        CustomFile qryDto = new CustomFile.Builder()
                                .templatePath("templates/returnJson/dto/qryDto.java.ftl")
                                .packageName("/entity/dto")
                                .fileName("QryDto.java")
                                .build();
                      CustomFile saveDto = new CustomFile.Builder()
                              .templatePath("templates/returnJson/dto/saveDto.java.ftl")
                              .packageName("/entity/dto")
                              .fileName("SaveDto.java")
                              .build();
                      CustomFile updateDto = new CustomFile.Builder()
                              .templatePath("/templates/returnJson/dto/updateDto.java.ftl")
                              .packageName("/entity/dto")
                              .fileName("UpdateDto.java")
                              .build();
                        CustomFile vo = new CustomFile.Builder()
                                .templatePath("/templates/returnJson/vo.java.ftl")
                                .packageName("/entity/vo")
                                .fileName("Vo.java")
                                .build();
                        list.add(qryDto);
                        list.add(saveDto);
                        list.add(updateDto);
                        list.add(vo);
                        builder.customFile(list);
                        builder.beforeOutputFile((tableInfo, stringObjectMap) -> {
                            String entityName = tableInfo.getEntityName();
                            stringObjectMap.put("entityQryDto",entityName+ "QryDto");
                            stringObjectMap.put("entitySaveDto",entityName+ "SaveDto");
                            stringObjectMap.put("entityUpdateDto",entityName + "UpdateDto");
                            stringObjectMap.put("entityVo",entityName + "Vo");
                        });


                })
                .templateEngine(new EnhanceFreemarkerTemplateEngine())
                .templateConfig(builder -> {
                    builder.controller("templates/returnJson/controller.java")
                            .service("templates/returnJson/service.java")
                            .serviceImpl("templates/returnJson/serviceImpl.java")
//                            .mapper("templates/returnJson/mapper.java")
//                            .xml("templates/returnJson/mapper.xml")
                            .entity("templates/returnJson/entity.java");



                })
                .execute();
    }

    /*
     * <p>
     * 读取控制台内容
     * </p>
     */

    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (StringUtils.isNotBlank(ipt)) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }

    public static final class EnhanceFreemarkerTemplateEngine extends FreemarkerTemplateEngine {

        /*
         * 输出自定义模板文件
         *
         * @param customFiles 自定义模板文件列表
         * @param tableInfo   表信息
         * @param objectMap   渲染数据
         * @since 3.5.3
         */
        @Override
        protected void outputCustomFile(@NotNull List<CustomFile> customFiles, @NotNull TableInfo tableInfo, @NotNull Map<String, Object> objectMap) {
            String entityName = tableInfo.getEntityName();
            String parentPath = getPathInfo(OutputFile.parent);
            customFiles.forEach(file -> {
                String filePath = StringUtils.isNotBlank(file.getFilePath()) ? file.getFilePath() : parentPath;
                if (StringUtils.isNotBlank(file.getPackageName())) {
                    filePath = filePath + File.separator + file.getPackageName();
                }
                String fileName = filePath + File.separator + entityName + file.getFileName();
                outputFile(new File(fileName), objectMap, file.getTemplatePath(), file.isFileOverride());
            });

//            objectMap.put()
        }
    }
}
