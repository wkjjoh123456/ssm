package service.test;

import cn.stud.entity.Area;
import cn.stud.entity.Stud;
import cn.stud.service.AreaService;
import cn.stud.service.StudService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Mr.K on 2018/6/9.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-context.xml")
public class studservicetest {

    @Resource
    private StudService studService;
    @Resource
    AreaService areaService;

    Stud stud;

    @Test
    public void test(){
       stud= studService.getStudById("s001");
        System.out.println(stud.getName());
    }

@Test

    public void query( ){

        List<Area> listarea =  areaService.select(1);
    JSONObject result = new JSONObject();
    JSONArray jsonArray = JSONArray.fromObject(listarea);

    System.out.println(jsonArray);
    }
}
