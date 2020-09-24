package felpa.io.projeto1.repository;

import felpa.io.projeto1.collection.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface UserRepository extends MongoRepository<User, Long> {

    User findByName(String name);

    User findByNameIgnoreCase(String name);

    User findByNameIgnoreCaseLike(String name);

    @Query("{'email' : ?0 }")
    User findQuery(String email);

}
