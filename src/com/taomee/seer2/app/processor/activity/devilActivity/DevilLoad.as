package com.taomee.seer2.app.processor.activity.devilActivity {
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class DevilLoad {


    private var _resourceLoader:ResourceLibraryLoader;

    private var _resLib:ResourceLibrary;

    public function DevilLoad() {
        super();
    }

    public function playLoad(param1:String, param2:Function):void {
        var url:String = param1;
        var loadComplete:Function = param2;
        if (this._resourceLoader) {
            loadComplete();
        } else {
            url = String(URLUtil.getActivityAnimation(url));
            this._resourceLoader = new ResourceLibraryLoader(url);
            this._resourceLoader.getLib(function (param1:ResourceLibrary):void {
                _resLib = param1;
                loadComplete();
            });
        }
    }

    public function getMC(param1:String):MovieClip {
        if (this._resLib) {
            return this._resLib.getMovieClip(param1);
        }
        return null;
    }

    public function dispose():void {
        if (this._resLib) {
            this._resLib.dispose();
        }
        if (this._resourceLoader) {
            this._resourceLoader.cancel(true);
            this._resourceLoader.dispose();
        }
        this._resourceLoader = null;
        this._resLib = null;
    }
}
}
