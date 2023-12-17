package com.taomee.seer2.app.arena.newUI.toolbar
{
   import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.taomee.utils.DisplayUtil;
   
   public class FightPointPanel extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _changFightUIBtn:SimpleButton;
      
      private var _prevBtn:SimpleButton;
      
      private var _nextBtn:SimpleButton;
      
      private var _contentTxt:TextField;
      
      private var _textFormat:TextFormat;
      
      private var _statusList:Vector.<String>;
      
      private var _currIndex:int;
      
      public function FightPointPanel()
      {
         super();
         this._mc = FightUIManager.getMovieClip("New_UI_Fight_Poing");
         this._changFightUIBtn = this._mc["changFightUIBtn"];
         this._prevBtn = this._mc["prevBtn"];
         this._nextBtn = this._mc["nextBtn"];
         this._contentTxt = new TextField();
         this._contentTxt.x = 42;
         this._contentTxt.y = 25;
         this._mc.addChild(this._contentTxt);
         this._contentTxt.width = 200;
         this._contentTxt.mouseEnabled = false;
         this._textFormat = new TextFormat();
         this._textFormat.color = 6750207;
         this._contentTxt.defaultTextFormat = this._textFormat;
         this._contentTxt.multiline = true;
         this._contentTxt.htmlText = "";
         this._changFightUIBtn.addEventListener(MouseEvent.CLICK,this.onChangFight);
         this._prevBtn.addEventListener(MouseEvent.CLICK,this.onPrev);
         this._nextBtn.addEventListener(MouseEvent.CLICK,this.onNext);
         this._statusList = Vector.<String>([]);
         this._currIndex = 0;
         addChild(this._mc);
      }
      
      private function updateStatus(param1:Vector.<String>) : void
      {
         var _loc2_:int = 0;
         this._contentTxt.htmlText = "";
         if(param1.length < 5)
         {
            param1.unshift(" ");
            this.updateStatus(param1);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < 5)
            {
               if(_loc2_ < 4)
               {
                  this._contentTxt.htmlText += param1[_loc2_] + "\n";
               }
               else
               {
                  this._contentTxt.htmlText += param1[_loc2_];
               }
               _loc2_++;
            }
         }
      }
      
      private function onChangFight(param1:MouseEvent) : void
      {
         if(SceneManager.active.type != SceneType.ARENA)
         {
            return;
         }
         ArenaUIIsNew.isNewUI = !ArenaUIIsNew.isNewUI;
         var _loc2_:String = ArenaUIIsNew.isNewUI ? "新" : "旧";
         ServerMessager.addMessage("下场战斗切换至" + _loc2_ + "UI");
      }
      
      private function onPrev(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this._statusList.length > this._currIndex + 5)
         {
            ++this._currIndex;
            _loc2_ = this._statusList.length - (this._currIndex + 5);
            this.updateStatus(this._statusList.slice(_loc2_,_loc2_ + 5));
         }
      }
      
      private function onNext(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this._currIndex > 0)
         {
            --this._currIndex;
            _loc2_ = this._statusList.length - (this._currIndex + 5);
            this.updateStatus(this._statusList.slice(_loc2_,_loc2_ + 5));
         }
      }
      
      public function entryValue(param1:String) : void
      {
         this._statusList.push(param1);
         this._currIndex = 0;
         if(this._statusList.length < 5)
         {
            this.updateStatus(this._statusList);
         }
         else
         {
            this.updateStatus(this._statusList.slice(this._statusList.length - 5,this._statusList.length));
         }
      }
      
      public function dispose() : void
      {
         DisplayUtil.removeForParent(this);
      }
   }
}
