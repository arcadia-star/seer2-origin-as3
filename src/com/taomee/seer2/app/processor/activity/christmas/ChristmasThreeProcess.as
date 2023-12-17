package com.taomee.seer2.app.processor.activity.christmas
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.activity.christmas.npc.ChristmasAKa;
   import com.taomee.seer2.app.processor.activity.christmas.npc.ChristmasDiDiLan;
   import com.taomee.seer2.app.processor.activity.christmas.npc.ChristmasLaAo;
   import com.taomee.seer2.app.processor.activity.christmas.npc.ChristmasXiaoYue;
   import com.taomee.seer2.app.processor.activity.christmas.npc.ChristmasXiuXiu;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class ChristmasThreeProcess
   {
      
      public static var isActivityFight:Boolean;
       
      
      private var _map:MapModel;
      
      private var _eventId:int;
      
      private var _npc:IChristmasNpc;
      
      private var _resourceLoader:ResourceLibraryLoader;
      
      private var _akaMC:MovieClip;
      
      public function ChristmasThreeProcess()
      {
         var url:String = null;
         super();
         if(SceneManager.prevSceneType == SceneType.ARENA && isActivityFight)
         {
            isActivityFight = false;
            url = String(URLUtil.getActivityAnimation("9/0"));
            this._resourceLoader = new ResourceLibraryLoader(url);
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this._resourceLoader.getLib(function(param1:ResourceLibrary):void
               {
                  var resLib:ResourceLibrary = param1;
                  _akaMC = resLib.getMovieClip("akaComplete");
                  LayerManager.topLayer.addChild(_akaMC);
                  _akaMC.x = 331;
                  _akaMC.y = 313;
                  InteractiveRewardManager.requestReward(57,function(param1:Parser_1060):void
                  {
                     var parser:Parser_1060 = param1;
                     MovieClipUtil.playMc(_akaMC,2,_akaMC.totalFrames,function():void
                     {
                        if(parser.activityCount == 0)
                        {
                           AlertManager.showAlert("哎哟！我们M5的礼物都被你拿光光了啦！明天再给你吧！");
                        }
                        else
                        {
                           parser.showResult();
                        }
                        DisplayUtil.removeForParent(_akaMC);
                     });
                  });
               });
            }
            else
            {
               NpcDialog.show(424,"阿卡",[[0,"囧……和你一战我更加忐忑！我觉得我有必要闭门去听听忐忑！以毒攻毒！"]],["……我也为此忐忑了！"],[function():void
               {
                  _resourceLoader.getLib(function(param1:ResourceLibrary):void
                  {
                     var resLib:ResourceLibrary = param1;
                     _akaMC = resLib.getMovieClip("akaComplete");
                     LayerManager.topLayer.addChild(_akaMC);
                     _akaMC.x = 331;
                     _akaMC.y = 313;
                     MovieClipUtil.playMc(_akaMC,2,_akaMC.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(_akaMC);
                     });
                  });
               }]);
            }
         }
      }
      
      public function startProcess(param1:MapModel) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            return;
         }
         this._map = param1;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,9,0);
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         this._eventId = _loc2_.readUnsignedInt();
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         if(this._eventId != 6 && QuestManager.isFreshQuestComplete() && _loc3_ == 9)
         {
            this.initRes();
         }
      }
      
      private function initRes() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("9/0"));
         this._resourceLoader = new ResourceLibraryLoader(_loc1_);
         this._resourceLoader.getLib(this.handlerGarbage);
      }
      
      private function handlerGarbage(param1:ResourceLibrary) : void
      {
         this.showNpc(param1);
      }
      
      private function showNpc(param1:ResourceLibrary) : void
      {
         switch(this._eventId)
         {
            case 1:
               this._npc = new ChristmasAKa();
               break;
            case 2:
               this._npc = new ChristmasDiDiLan(param1);
               break;
            case 3:
               this._npc = new ChristmasXiuXiu(param1);
               break;
            case 4:
               this._npc = new ChristmasLaAo(param1);
               break;
            case 5:
               this._npc = new ChristmasXiaoYue(param1);
         }
         this._npc.playAnimation();
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         DisplayUtil.removeForParent(this._akaMC);
         this._akaMC = null;
         if(this._npc)
         {
            this._npc.dispose();
         }
         this._npc = null;
         if(this._resourceLoader)
         {
            this._resourceLoader.cancel();
         }
         this._resourceLoader = null;
      }
   }
}
