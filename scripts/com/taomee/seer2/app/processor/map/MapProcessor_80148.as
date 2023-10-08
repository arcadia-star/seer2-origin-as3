package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class MapProcessor_80148 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:int = 825;
      
      private static const BOSS_POS:Vector.<int> = Vector.<int>([479,283]);
       
      
      private var _resLib:ApplicationDomain;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _bossNpc:Mobile;
      
      public function MapProcessor_80148(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.getURL();
      }
      
      private function getURL() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            TweenNano.delayedCall(1,function():void
            {
               SceneManager.changeScene(SceneType.COPY,80147);
            });
            return;
         }
         QueueLoader.load(URLUtil.getActivityAnimation("miuSiAct/MiuSiAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            initSet();
         });
      }
      
      private function initSet() : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("MiuSiSpecialPanel"),"正在打开面板...",{"func":this.start});
      }
      
      private function start() : void
      {
         var sceneMC:MovieClip = null;
         sceneMC = this.getMovie("SceneMC");
         _map.front.addChild(sceneMC);
         MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
         {
            sceneMC.gotoAndStop(1);
            DisplayUtil.removeForParent(sceneMC);
            sceneMC = null;
            addNpc();
         },true);
      }
      
      private function addNpc() : void
      {
         this._bossNpc = new Mobile();
         this._bossNpc.width = 150;
         this._bossNpc.height = 150;
         this._bossNpc.setPostion(new Point(BOSS_POS[0],BOSS_POS[1]));
         this._bossNpc.resourceUrl = URLUtil.getNpcSwf(705);
         this._bossNpc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._bossNpc.label = "缪斯";
         this._bossNpc.labelImage.y = -this._bossNpc.height - 10;
         this._bossNpc.buttonMode = true;
         MobileManager.addMobile(this._bossNpc,MobileType.NPC);
         this.showMouseHintAtMonster(this._bossNpc);
         this._bossNpc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(705,"缪斯",[[0,"你是小赛尔吧，我常听雷伊、盖亚它们提到你。少主之星会摧毁这个穹顶带我们离开！"]],["少主之星？","女神哇！"],[function():void
         {
            NpcDialog.hide();
            NpcDialog.show(705,"缪斯",[[0,"是的！我无法自己释放，只有被击败后才能从我体内释放出少主之星。你愿意和我挑战吗？"]],["愿意！我愿意为女神做一切！"],[function():void
            {
               FightManager.startFightWithWild(FIGHT_INDEX);
            }]);
         }]);
      }
      
      private function removeBossNpc() : void
      {
         if(this._bossNpc)
         {
            this.removeMouseHint();
            this._bossNpc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._bossNpc);
            this._bossNpc = null;
         }
      }
      
      private function showMouseHintAtMonster(param1:Sprite) : void
      {
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.y = -param1.height - 10;
         this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 - 40;
         param1.addChild(this._mouseHint);
      }
      
      private function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(this._mouseHint);
         this._mouseHint = null;
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      private function zombieDrActDispose() : void
      {
         this.removeBossNpc();
         this.removeMouseHint();
         this._resLib = null;
      }
      
      override public function dispose() : void
      {
         this.zombieDrActDispose();
         super.dispose();
      }
   }
}
