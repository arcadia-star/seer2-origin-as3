package com.taomee.seer2.app.arena.util {
public class FightState {

    public static const PRESENTATION:String = "presentation";

    public static const FIGHTING:String = "fighting";

    public static const CHANGE_LEFT_FIGHTER:String = "changeLeftFighter";

    public static const CHANGE_RIGHT_FIGHTER:String = "changeRightFighter";

    public static const CATCH_FIGHTER_SUCCESS:String = "catchFighterSuccess";

    public static const CATCH_FIGHTER_FAILED:String = "catchFighterFailed";

    public static const ESCAPE:String = "escape";

    public static const OPPOSITE_ESCAPE:String = "oppositeEscape";


    public function FightState() {
        super();
    }
}
}
