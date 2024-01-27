package com.taomee.seer2.app.home.dailyQuest {
public class HomeDailyCategory {


    private var _id:int;

    private var _name:String;

    private var _questVec:Vector.<HomeDailyQuest>;

    public function HomeDailyCategory(param1:int, param2:String) {
        super();
        this._id = param1;
        this._name = param2;
        this._questVec = new Vector.<HomeDailyQuest>();
    }

    public function addQuest(param1:HomeDailyQuest):void {
        this._questVec.push(param1);
        param1.category = this;
    }

    public function get id():int {
        return this._id;
    }
}
}
