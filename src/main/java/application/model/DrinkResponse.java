package application.model;

/**
 * Created by wg on 11/19/17.
 */
public class DrinkResponse extends Response {
    private String drinkName;
    private static String drinkType = "drink";

    public DrinkResponse(String drinkName){
        super(drinkType);
        this.drinkName = drinkName;
    }

    public String getDrinkName() {
        return drinkName;
    }

    public void setDrinkName(String drinkName) {
        this.drinkName = drinkName;
    }
}
