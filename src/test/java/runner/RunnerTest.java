package runner;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;
import io.qameta.allure.karate.AllureKarate;

public class RunnerTest {

  @Test
  Karate testAll() {
    return Karate
        .run("classpath:features")
        .relativeTo(getClass())
        .hook(new AllureKarate())
        .outputJunitXml(true)
        .outputCucumberJson(true);
  }
}
