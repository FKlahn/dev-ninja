package felpa.io.projeto1.repository;

import felpa.io.projeto1.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByName(String name);

    User findByNameIgnoreCase(String name);

    @Query("select u from User u where u.name like %?1%")
    User findByQuery(String name);

}
