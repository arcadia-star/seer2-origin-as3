package com.taomee.seer2.app.notify.data.notice {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

public class LeiyiKaisaNotice extends Notice {


    public function LeiyiKaisaNotice(param1:String, param2:uint) {
        super(NoticeType.LEIYI_KAISA_FIGHT, ActorManager.actorInfo.id);
    }

    override public function process():void {
        ModuleManager.showModule(URLUtil.getAppModule("LeiyiKaisaNoticePanel"), "正在加载资源...");
    }
}
}
