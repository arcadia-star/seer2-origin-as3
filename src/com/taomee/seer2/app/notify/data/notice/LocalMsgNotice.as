package com.taomee.seer2.app.notify.data.notice {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class LocalMsgNotice extends Notice {


    private var _obj:Object;

    public function LocalMsgNotice(param1:Object) {
        this._obj = param1;
        super(NoticeType.LOCALMSG, ActorManager.actorInfo.id);
    }

    override public function process():void {
        switch (this._obj.type) {
            case "module":
                ModuleManager.toggleModule(URLUtil.getAppModule(this._obj.param1), "正在面板...", this._obj.param2);
        }
        ServerBufferManager.updateServerBuffer(ServerBufferType.LOCAL_MESSAGE, this._obj.index, this._obj.value);
    }
}
}
