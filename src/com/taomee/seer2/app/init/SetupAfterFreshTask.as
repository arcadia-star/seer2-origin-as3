package com.taomee.seer2.app.init {
import com.taomee.seer2.app.actives.BingyiteSuperAct;
import com.taomee.seer2.app.actives.DiamondTaskNewManager;
import com.taomee.seer2.app.actives.LihuaAct;
import com.taomee.seer2.app.actives.SkyFightManager;
import com.taomee.seer2.app.actives.WaitNewYearSetup;
import com.taomee.seer2.app.actives.WorshipPhenixAct;
import com.taomee.seer2.app.actives.WorshipStoneCupAct;
import com.taomee.seer2.app.activity.ActivityManager;
import com.taomee.seer2.app.activity.processor.PetTeamActivity;
import com.taomee.seer2.app.common.RubbishCommon;
import com.taomee.seer2.app.controller.MolecularPasswordController;
import com.taomee.seer2.app.dream.DreamMapManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.LocalMsgManager;
import com.taomee.seer2.app.manager.LoginAwardManager;
import com.taomee.seer2.app.manager.MeshBeastReviveManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.morphSystem.MorphUpdate;
import com.taomee.seer2.app.offLineExp.OffLineExpSystem;
import com.taomee.seer2.app.pet.MysteryNpcManager;
import com.taomee.seer2.app.pet.PetItemUpdate;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.activity.anniversaryParade.ActivityAnniversaryParade;
import com.taomee.seer2.app.processor.activity.deliciousFood.DeliciousFoodOnePickup;
import com.taomee.seer2.app.processor.activity.diluControl.DiluManager;
import com.taomee.seer2.app.processor.activity.evilBodyAct.EvilBodyAct;
import com.taomee.seer2.app.processor.activity.fightPrev.FightPrevManager;
import com.taomee.seer2.app.processor.activity.fishingMatch.FishingMatchManager;
import com.taomee.seer2.app.processor.activity.leiYiWingFirstComeAct.LeiYiWingFirstComeAct;
import com.taomee.seer2.app.processor.activity.miKaAndContractAct.MiKaAndContractAct;
import com.taomee.seer2.app.processor.activity.npcPosHandle.NpcPosHandle;
import com.taomee.seer2.app.processor.activity.pkKingCallAct.PkKingCallAct;
import com.taomee.seer2.app.processor.activity.planet.PlanetManager;
import com.taomee.seer2.app.processor.activity.sLianYuAct.SLianYuAct;
import com.taomee.seer2.app.processor.activity.xegg.XeggHome;
import com.taomee.seer2.app.processor.activity.yiXingFindAndFightAct.YiXingFindAndFightAct;
import com.taomee.seer2.app.processor.activity.yiteFigthPve.YiTeEndingGetInfo;
import com.taomee.seer2.app.processor.quest.Quest1InitNono;
import com.taomee.seer2.app.rarePet.RarePetManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.log.Logger;
import com.taomee.seer2.core.scene.LayerManager;

import flash.events.SyncEvent;

import org.taomee.bean.BaseBean;

public class SetupAfterFreshTask extends BaseBean {


    public function SetupAfterFreshTask() {
        super();
    }

    override public function start():void {
        SkyFightManager.getInstance().addListener();
        ActivityManager.refreshActivity();
        StatisticsManager.setup();
        RarePetManager.setup();
        MolecularPasswordController.setup();
        RightToolbarConter.instance.initEvent();
        FishingMatchManager.getInstance().setup();
        LoginAwardManager.isShowPanel(LoginInfo.isShowLoginAwardPanel);
        LocalMsgManager.getInstance().setup();
        MorphUpdate.updateMorph();
        MeshBeastReviveManager.instance.setup();
        WorshipStoneCupAct.getInstance().setup();
        XeggHome.setup();
        WorshipPhenixAct.getInstance().setup();
        PlanetManager.setup();
        DeliciousFoodOnePickup.setup();
        WaitNewYearSetup.setup();
        YiXingFindAndFightAct.getInstance().setup();
        PetItemUpdate.setup();
        MysteryNpcManager.setup();
        Quest1InitNono.setup();
        PetTeamActivity.setup();
        RubbishCommon.setup();
        OffLineExpSystem.setup();
        FightPrevManager.startFightPrev();
        DiluManager.setup();
        DreamMapManager.setup();
        DiamondTaskNewManager.setup();
        MiKaAndContractAct.setup();
        LeiYiWingFirstComeAct.setup();
        SLianYuAct.setup();
        PkKingCallAct.setup();
        EvilBodyAct.setup();
        NpcPosHandle.setup();
        ActivityAnniversaryParade.instance.setup();
        LihuaAct.init();
        BingyiteSuperAct.init();
        ItemManager.requestItemList(function ():void {
            if (YiTeEndingGetInfo.getInstance().hasGetInfo == 0) {
                YiTeEndingGetInfo.getInstance().getRankInfo();
            }
        });
        finish();
        Logger.isDebug = false;
        if (Logger.isDebug) {
            LayerManager.stage.addEventListener("OverMaxSize", this.alertMaxSize);
        }
    }

    protected function alertMaxSize(param1:SyncEvent):void {
        var _loc2_:String = String(param1.changeList[0]);
        AlertManager.showAlert("素材大小:" + param1.changeList[1] + "k\nurl:" + param1.changeList[0]);
    }
}
}
