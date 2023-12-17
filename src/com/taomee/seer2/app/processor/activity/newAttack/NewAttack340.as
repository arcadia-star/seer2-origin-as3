package com.taomee.seer2.app.processor.activity.newAttack
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class NewAttack340 extends BaseNewAttack
   {
      
      private static var _fightStatus:uint;
       
      
      private var _flyYite:MovieClip;
      
      public function NewAttack340()
      {
         super();
         this.setup();
      }
      
      private function setup() : void
      {
         var date:Date = null;
         var da:int = 0;
         var dataVec:Vector.<ServerBufferData> = null;
         if(SceneManager.prevSceneType == SceneType.ARENA && _fightStatus == 1)
         {
            _fightStatus = 0;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               date = new Date(TimeManager.getServerTime() * 1000);
               da = int(date.date);
               dataVec = new Vector.<ServerBufferData>();
               dataVec.push(new ServerBufferData(2,1));
               dataVec.push(new ServerBufferData(4,da));
               ServerBufferManager.updateServerBufferGroup(ServerBufferType.NEW_ATTACK,dataVec);
               ServerBufferManager.getServerBuffer(ServerBufferType.NEW_ATTACK,this.getServerList,false);
               playLoad(function():void
               {
                  win();
               });
               return;
            }
         }
         if(checkTime)
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEW_ATTACK,this.getServer,false);
         }
      }
      
      private function getServer(param1:ServerBuffer) : void
      {
         var _loc7_:Vector.<ServerBufferData> = null;
         var _loc2_:int = param1.readDataAtPostion(0);
         var _loc3_:int = param1.readDataAtPostion(2);
         var _loc4_:int = param1.readDataAtPostion(4);
         var _loc5_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc6_:int = int(_loc5_.date);
         if(_loc4_ != _loc6_)
         {
            (_loc7_ = new Vector.<ServerBufferData>()).push(new ServerBufferData(0,0));
            _loc7_.push(new ServerBufferData(1,0));
            _loc7_.push(new ServerBufferData(2,0));
            _loc7_.push(new ServerBufferData(3,0));
            ServerBufferManager.updateServerBufferGroup(ServerBufferType.NEW_ATTACK,_loc7_);
            return;
         }
         if(_loc2_ == 1 && _loc3_ != 1)
         {
            playLoad(this.playComplete);
         }
      }
      
      private function playComplete() : void
      {
         this.initMC();
         this.initEvent();
      }
      
      private function initMC() : void
      {
         this._flyYite = getMC("flyYite");
         LayerManager.uiLayer.addChild(this._flyYite);
         this._flyYite.play();
      }
      
      private function initEvent() : void
      {
         this._flyYite.buttonMode = true;
         this._flyYite.addEventListener(MouseEvent.CLICK,this.onFlyYite);
      }
      
      private function onFlyYite(param1:MouseEvent) : void
      {
         _fightStatus = 1;
         FightManager.startFightWithWild(83);
      }
      
      private function win() : void
      {
         NpcDialog.show(476,"飞伊特",[[3,"哼！都不懂得享受生活！扫兴！我要回实验禁地找我的兄弟们。"]],["我会孜孜不倦地阻止你的！"],[function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NewAttackPanel"),"正在打开面板...");
         }]);
      }
      
      private function getServerList(param1:ServerBuffer) : void
      {
         var _loc5_:Vector.<ServerBufferData> = null;
         var _loc2_:int = param1.readDataAtPostion(1);
         var _loc3_:int = param1.readDataAtPostion(2);
         var _loc4_:int = param1.readDataAtPostion(3);
         if(_loc2_ == 1 && _loc3_ == 1 && _loc4_ == 1)
         {
            (_loc5_ = new Vector.<ServerBufferData>()).push(new ServerBufferData(0,0));
            _loc5_.push(new ServerBufferData(1,0));
            _loc5_.push(new ServerBufferData(2,0));
            _loc5_.push(new ServerBufferData(3,0));
            ServerBufferManager.updateServerBufferGroup(ServerBufferType.NEW_ATTACK,_loc5_);
         }
      }
      
      public function mapDispose() : void
      {
         DisplayUtil.removeForParent(this._flyYite);
         this._flyYite = null;
      }
   }
}
