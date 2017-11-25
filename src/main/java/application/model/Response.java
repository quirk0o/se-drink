package application.model;

/**
 * Created by wg on 11/19/17.
 */
public class Response {
    private String type;

    protected Response(String type){
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
