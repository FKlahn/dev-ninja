package felpa.io.projeto1.config;

import felpa.io.projeto1.entity.User;
import felpa.io.projeto1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DataIntializer implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    UserRepository userRepository;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        List<User> users = userRepository.findAll();

        if (users.isEmpty()) {
            createUser("Felipe Klahn", "klahnmuniz@gmail.com");
            createUser("Springboot", "spring@gmail.com");
            createUser("Java", "java@gmail.com");
        }

        User user = userRepository.getOne(2L);
        User userName = userRepository.findByName("Felipe Klahn");
        User userQuery = userRepository.findByQuery("Spri");
        User ignorecase = userRepository.findByNameIgnoreCase("jAvA");
        System.out.println(userName.getName() +" / " + userName.getEmail());
        System.out.println(user.getName());
        System.out.println(userQuery.getName() +" / " + userQuery.getEmail());
        System.out.println(ignorecase.getName() +" / " + ignorecase.getEmail());
    }


    public void createUser(String name, String email) {
        User user = new User(name, email);
        userRepository.save(user);
    }
}