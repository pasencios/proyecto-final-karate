package bdd;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate testLogin() {
        return Karate.run("auth/loginAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate testRegister() {
        return Karate.run("auth/registerAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetProduct() {
        return Karate.run("product/getByProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate testNewProduct() {
        return Karate.run("product/newProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUpdateProduct() {
        return Karate.run("product/updateProduct").relativeTo(getClass());
    }

}
