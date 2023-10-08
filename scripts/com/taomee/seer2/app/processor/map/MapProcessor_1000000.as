package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_1000000 extends MapProcessor
   {
      
      private static var _hasFirstFight:Boolean;
      
      private static var _hasFightAgain:Boolean;
       
      
      private var _leiyi_mc:MovieClip;
      
      private var _yandi_mc:MovieClip;
      
      private var _tan1_mc:MovieClip;
      
      private var _tan2_mc:MovieClip;
      
      public function MapProcessor_1000000(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         var flag:int = 0;
         this._tan1_mc = _map.content["tan1"];
         this._tan2_mc = _map.content["tan2"];
         this._yandi_mc = _map.content["yandi"];
         ServerBufferManager.getServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,function(param1:ServerBuffer):void
         {
            flag = param1.readDataAtPostion(0);
            if(flag == 0)
            {
               _yandi_mc.buttonMode = true;
               _tan1_mc.visible = false;
               _yandi_mc.addEventListener(MouseEvent.CLICK,beginStoryHandler);
               if(SceneManager.prevSceneType == SceneType.ARENA && _hasFirstFight)
               {
                  _hasFirstFight = false;
                  if(FightManager.fightWinnerSide == FightSide.LEFT)
                  {
                     win();
                  }
                  else
                  {
                     noWin();
                  }
               }
            }
            else if(flag == 1)
            {
               creatLeiyi();
               if(SceneManager.prevSceneType == SceneType.ARENA && _hasFirstFight)
               {
                  _hasFightAgain = false;
                  if(FightManager.fightWinnerSide == FightSide.LEFT)
                  {
                     winAgain();
                  }
                  else
                  {
                     noWinAgain();
                  }
               }
            }
         });
      }
      
      private function creatLeiyi() : void
      {
         this._yandi_mc.visible = false;
         this._tan2_mc.visible = false;
         this._tan1_mc.visible = true;
         this._leiyi_mc = _map.content["leiyi"];
         this._leiyi_mc.buttonMode = true;
         this._leiyi_mc.addEventListener(MouseEvent.CLICK,this.fightLeiyiHandler);
      }
      
      private function beginStoryHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(499,"炎帝",[[0,"等我解决了眼前这个强大的对手后再来招呼你！"]],["斩杀雷伊？你别想了！！"],[function():void
         {
            NpcDialog.show(477,"雷伊",[[0,"<font color=\'#ffcc00\'>{$name}</font>，你是来为我助阵的吗？"]],["帮助雷伊","离开"],[function():void
            {
               _hasFirstFight = true;
               FightManager.startFightWithNPC(27);
            }]);
         }]);
      }
      
      private function win() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("leiyiCenturyFight"),function():void
         {
            _yandi_mc.removeEventListener(MouseEvent.CLICK,beginStoryHandler);
            ServerBufferManager.updateServerBuffer(ServerBufferType.LEIYI_CENTURY_FIGHT,0,1);
            creatLeiyi();
         },true,false,2);
      }
      
      private function noWin() : void
      {
         NpcDialog.show(477,"雷伊",[[0,"这次失败不算什么，准备好再战一场了吗？"]],["再战一场","离开"],[function():void
         {
            _hasFirstFight = true;
            FightManager.startFightWithNPC(27);
         }]);
      }
      
      private function fightLeiyiHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(477,"雷伊",[[0,"难得的战斗就这样结束了，要不你来当我的对手吧！"]],["挑战雷伊","离开"],[function():void
         {
            _hasFightAgain = true;
            FightManager.startFightWithWild(115);
         }]);
      }
      
      private function winAgain() : void
      {
      }
      
      private function noWinAgain() : void
      {
         NpcDialog.show(477,"雷伊",[[0,"这次失败不算什么，准备好再战一场了吗？"]],["再战一场","离开"],[function():void
         {
            _hasFirstFight = true;
            FightManager.startFightWithWild(115);
         }]);
      }
      
      override public function dispose() : void
      {
      }
   }
}
