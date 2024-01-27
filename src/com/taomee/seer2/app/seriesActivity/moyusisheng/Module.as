package com.taomee.seer2.app.seriesActivity.moyusisheng {
import com.taomee.seer2.app.seriesActivity.SeriesActivityBaseModule;

public class Module extends SeriesActivityBaseModule {


    public function Module() {
        super();
        _controllerClass = Controller;
    }

    public function get moduleConfig():Config {
        return config as Config;
    }
}
}
