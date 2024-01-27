package com.taomee.seer2.app.manager {
public class FirstVipManager {

    private static var _instance:FirstVipManager;


    public function FirstVipManager(param1:InterClass) {
        super();
    }

    public static function getInstance():FirstVipManager {
        if (_instance == null) {
            _instance = new FirstVipManager(new InterClass());
        }
        return _instance;
    }

    public function setup():void {
    }
}
}

class InterClass {


    public function InterClass() {
        super();
    }
}
