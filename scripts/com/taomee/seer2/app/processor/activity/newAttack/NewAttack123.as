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
   
   public class NewAttack123 extends BaseNewAttack
   {
      
      private static var _fightStatus:uint;
       
      
      private var _bugYite:MovieClip;
      
      public function NewAttack123()
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
               dataVec.push(new ServerBufferData(3,1));
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
         var _loc3_:int = param1.readDataAtPostion(3);
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
         this._bugYite = getMC("bugYite");
         LayerManager.uiLayer.addChild(this._bugYite);
         this._bugYite.play();
      }
      
      private function initEvent() : void
      {
         this._bugYite.buttonMode = true;
         this._bugYite.addEventListener(MouseEvent.CLICK,this.onbugYite);
      }
      
      private function onbugYite(param1:MouseEvent) : void
      {
         _fightStatus = 1;
         FightManager.startFightWithWild(84);
      }
      
      private function win() : void
      {
         NpcDialog.show(473,"虫伊特",[[2,"算了……我可不想再把牙齿崩掉了……先撤退！"]],["我会孜孜不倦地阻止你的！"],[function():void
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
         DisplayUtil.removeForParent(this._bugYite);
         this._bugYite = null;
      }
   }
}
