package com.taomee.seer2.app.processor.activity.homeActiviry
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.home.HomeScene;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class SemiyaAvtivity
   {
      
      private static var isFight:Boolean = false;
       
      
      private var _resLoadLib:ResourceLibraryLoader;
      
      private var _npc:MovieClip;
      
      public function SemiyaAvtivity()
      {
         var _loc1_:Number = NaN;
         this._resLoadLib = new ResourceLibraryLoader(URLUtil.getRes("common/home/semiya" + URLUtil.POSTFIX_SWF));
         super();
         if(SceneManager.prevSceneType == SceneType.ARENA && isFight)
         {
            isFight = false;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
            }
            else
            {
               this.noWin();
            }
            return;
         }
         if(SceneManager.active.mapID != ActorManager.actorInfo.id)
         {
            if((SceneManager.active as HomeScene).homeInfo.semiyaCount < 20)
            {
               _loc1_ = Math.random() * 100;
               if(_loc1_ < 30)
               {
                  this.startActivity();
               }
            }
         }
      }
      
      private function startActivity() : void
      {
         this._resLoadLib.getLib(function(param1:ResourceLibrary):void
         {
            _npc = param1.getMovieClip("npc");
            _npc.x = 454;
            _npc.y = 137;
            SceneManager.active.mapModel.content.addChild(_npc);
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK,onClick);
         });
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(600,"瑟咪娅",[[0,"呀呀呀~被你发现了，想要我的彩蛋吗？来和我对战吧。"]],["开始对战","我准备一下"],[function():void
         {
            isFight = true;
            FightManager.startFightWithWild(516);
         }]);
      }
      
      private function win() : void
      {
         NpcDialog.show(600,"瑟咪娅",[[0,"哇，你赢了，彩蛋给你，我又要躲起来了，快来找我呀。"]],["我来了"],[function():void
         {
            if((SceneManager.active as HomeScene).homeInfo.semiyaCount >= 20)
            {
               NpcDialog.show(600,"瑟咪娅",[[0,"啊，今天我要走了，你玩得开心吗？明天再来找我吧。"]],["好的"]);
            }
         }]);
      }
      
      private function noWin() : void
      {
         NpcDialog.show(600,"瑟咪娅",[[0,"哈哈，你输了吧，我要躲起来了，你找到我再给你彩蛋。"]],["我来了"],[function():void
         {
            if((SceneManager.active as HomeScene).homeInfo.semiyaCount >= 20)
            {
               NpcDialog.show(600,"瑟咪娅",[[0,"啊，今天我要走了，你玩得开心吗？明天再来找我吧。"]],["好的"]);
            }
         }]);
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeFromParent(this._npc);
      }
   }
}
