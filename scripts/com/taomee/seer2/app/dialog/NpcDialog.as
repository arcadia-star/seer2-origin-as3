package com.taomee.seer2.app.dialog
{
   import com.adobe.serialization.json.JSON;
   import com.greensock.TweenMax;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.Guider;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.dialog.functionality.FunctionalityUnitFactory;
   import com.taomee.seer2.app.dialog.functionality.InputUnit;
   import com.taomee.seer2.app.home.panel.HomePanel;
   import com.taomee.seer2.app.questTiny.QuestTinyPanel;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import com.taomee.seer2.core.utils.Util;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.MathUtil;
   
   public class NpcDialog extends Sprite
   {
      
      public static var hasHideDialog:Boolean = false;
      
      public static const NICK_FLAG:String = "$nick$";
      
      private static var _instance:com.taomee.seer2.app.dialog.NpcDialog;
       
      
      private var _prevNpcId:uint = 0;
      
      private var _back:MovieClip;
      
      private var _contentTxt:TextField;
      
      private var _npcPreview:com.taomee.seer2.app.dialog.NpcPreview;
      
      private var _nextNodeBtn:SimpleButton;
      
      private var _labelFormat:TextFormat;
      
      private var _labelBtnVec:Vector.<SimpleButton>;
      
      private var _emotionList:Vector.<MovieClip>;
      
      private var _npcId:int;
      
      private var _npcName:String;
      
      private var _nodeArr:Array;
      
      private var _nodeIndex:int;
      
      private var _closeArr:Array;
      
      private var _closeHandlerArr:Array;
      
      private var _contentFormat:TextFormat;
      
      private var _numLines:int;
      
      private var _isShowing:Boolean;
      
      private var _functionUnitSp:Sprite;
      
      public function NpcDialog()
      {
         super();
         this.init();
      }
      
      public static function show(param1:int, param2:String, param3:Array, param4:Array, param5:Array = null) : void
      {
         hasHideDialog = false;
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.dialog.NpcDialog();
         }
         _instance._npcId = param1;
         _instance._npcName = param2;
         _instance._nodeArr = param3;
         _instance._closeArr = param4;
         _instance._closeHandlerArr = param5;
         _instance.showInstance();
      }
      
      public static function showDialogsByText(param1:String, param2:Function, param3:Function = null) : void
      {
         var url:String = param1;
         var fun:Function = param2;
         var fun1:Function = param3;
         QueueLoader.load(URLUtil.getRes(url),LoadType.TEXT,function(param1:ContentInfo):void
         {
            var dialogs:Array = null;
            var infos:ContentInfo = param1;
            try
            {
               dialogs = com.adobe.serialization.json.JSON.decode(infos.content);
            }
            catch(e:*)
            {
               throw new Error("json 格式错误：" + url);
            }
            com.taomee.seer2.app.dialog.NpcDialog.showDialogs(dialogs,fun,fun1);
         });
      }
      
      public static function showDialogs(param1:Array, param2:Function, param3:Function = null) : void
      {
         var index:int = 0;
         var arr:Array = param1;
         var fun:Function = param2;
         var fun1:Function = param3;
         index = 0;
         var showFun:Function = function():void
         {
            var dialog:Array = arr[index];
            show(dialog[0],dialog[1],dialog[2],dialog[3],[function():void
            {
               ++index;
               if(index == arr.length)
               {
                  fun();
               }
               else
               {
                  showFun();
               }
            },function():void
            {
               if(fun1 != null)
               {
                  fun1();
               }
            }]);
         };
         showFun();
      }
      
      public static function showForNew(param1:int, param2:String, param3:Array, param4:String, param5:Function = null) : void
      {
         var npcId:int = param1;
         var npcName:String = param2;
         var nodeArr:Array = param3;
         var closeNode:String = param4;
         var closeHandler:Function = param5;
         var closeHandlerArr:Array = [function():void
         {
            Guider.hide();
            if(closeHandler != null)
            {
               closeHandler();
            }
         }];
         var closeArr:Array = [closeNode];
         show(npcId,npcName,nodeArr,closeArr,closeHandlerArr);
         Guider.show(860 - closeNode.length * 5,620);
      }
      
      public static function addFunctionUnit(param1:String, param2:String, param3:String, param4:Function = null) : void
      {
         _instance.addFunctionUnit(param1,param2,param3,param4);
      }
      
      public static function addInputUnit(param1:Function) : void
      {
         _instance.addInputUnit(param1);
      }
      
      public static function hide() : void
      {
         if(Boolean(_instance) && _instance.isShowing())
         {
            hasHideDialog = true;
            _instance.hideInstance();
         }
      }
      
      public static function reShow() : void
      {
         if(hasHideDialog && Boolean(_instance))
         {
            hasHideDialog = false;
            _instance.showInstance();
         }
      }
      
      private static function replacePlayerName(param1:String) : String
      {
         return param1.replace(NICK_FLAG,ActorManager.actorInfo.nick);
      }
      
      private function init() : void
      {
         this.createBack();
         this.createNpcPreview();
         this.createContentTxt();
         this.createNextNode();
      }
      
      private function createBack() : void
      {
         this._back = UIManager.getMovieClip("UI_DialogPanel");
         this._back.x = 145;
         this._back.y = 410;
         addChild(this._back);
         this._functionUnitSp = new Sprite();
         this._functionUnitSp.x = 340;
         this._functionUnitSp.y = 470;
         addChild(this._functionUnitSp);
      }
      
      private function createNpcPreview() : void
      {
         this._npcPreview = new com.taomee.seer2.app.dialog.NpcPreview();
         this._npcPreview.x = 210;
         this._npcPreview.y = 562;
         addChild(this._npcPreview);
      }
      
      private function createContentTxt() : void
      {
         this._contentFormat = new TextFormat();
         this._contentFormat.size = 14;
         this._contentFormat.color = 5432825;
         this._contentFormat.font = "_sans";
         this._contentTxt = new TextField();
         this._contentTxt.multiline = true;
         this._contentTxt.wordWrap = true;
         this._contentTxt.width = 450;
         this._contentTxt.height = 40;
         this._contentTxt.selectable = false;
         this._contentTxt.defaultTextFormat = this._contentFormat;
         this._contentTxt.x = 340;
         this._contentTxt.y = 440;
         addChild(this._contentTxt);
      }
      
      private function createNextNode() : void
      {
         this._nextNodeBtn = UIManager.getButton("UI_DialogNextNode");
         this._nextNodeBtn.addEventListener(MouseEvent.CLICK,this.onNextNode);
         this._nextNodeBtn.x = 760;
         this._nextNodeBtn.y = 530;
      }
      
      private function createReplyBtn(param1:String) : SimpleButton
      {
         var _loc2_:Sprite = this.createBtnState(param1,16777113);
         var _loc3_:Sprite = this.createBtnState(param1,9696572);
         var _loc4_:Sprite = this.createBtnState(param1,16777113);
         var _loc5_:Shape = this.createBtnHitState(_loc4_.width);
         return new SimpleButton(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      private function createBtnState(param1:String, param2:uint) : Sprite
      {
         if(this._labelFormat == null)
         {
            this._labelFormat = new TextFormat();
            this._labelFormat.size = 18;
            this._labelFormat.underline = true;
            this._labelFormat.bold = true;
         }
         this._labelFormat.color = param2;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:TextField;
         (_loc4_ = new TextField()).defaultTextFormat = this._labelFormat;
         _loc4_.type = TextFieldType.DYNAMIC;
         _loc4_.selectable = false;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.htmlText = replacePlayerName(param1);
         _loc3_.addChild(_loc4_);
         return _loc3_;
      }
      
      private function createBtnHitState(param1:int) : Shape
      {
         var _loc2_:Shape = new Shape();
         var _loc3_:Graphics = _loc2_.graphics;
         _loc3_.beginFill(16777215,0);
         _loc3_.drawRect(0,0,param1,25);
         _loc3_.endFill();
         return _loc2_;
      }
      
      private function onNextNode(param1:MouseEvent) : void
      {
         if(this._closeArr.length <= 0 && this._closeHandlerArr != null && this._closeHandlerArr[0] != null)
         {
            this.hideInstance();
            this._closeHandlerArr[0]();
            return;
         }
         ++this._nodeIndex;
         this.updateView();
      }
      
      private function addFunctionUnit(param1:String, param2:String, param3:String, param4:Function) : void
      {
         var _loc5_:BaseUnit = null;
         var _loc6_:int = 0;
         if(this._isShowing == true)
         {
            if((_loc5_ = FunctionalityUnitFactory.createUnit(param1,param2,param3)) is CustomUnit)
            {
               (_loc5_ as CustomUnit).customHandler = param4;
            }
            this._functionUnitSp.addChild(_loc5_);
            this._functionUnitSp.getChildAt(0).y = 30;
            _loc6_ = 1;
            while(_loc6_ < this._functionUnitSp.numChildren)
            {
               this._functionUnitSp.getChildAt(_loc6_).x = 150 * int(_loc6_ % 2);
               this._functionUnitSp.getChildAt(_loc6_).y = 30 + 30 * int(_loc6_ / 2);
               _loc6_++;
            }
         }
      }
      
      private function addInputUnit(param1:Function) : void
      {
         var _loc2_:InputUnit = null;
         if(this._isShowing == true)
         {
            _loc2_ = new InputUnit(param1);
            _loc2_.mouseEnabled = true;
            this._functionUnitSp.mouseEnabled = true;
            this.mouseEnabled = true;
            this._functionUnitSp.addChild(_loc2_);
         }
      }
      
      private function showInstance() : void
      {
         if(this._isShowing == true)
         {
            this.hideInstance();
         }
         this._isShowing = true;
         this._nodeIndex = 0;
         this.layIcons();
         if(_instance._npcId != this._prevNpcId)
         {
            this.tweenDialog();
            this._prevNpcId = _instance._npcId;
         }
         LayerManager.topLayer.addChild(this);
         LayerManager.focusOnTopLayer();
         DialogPanel.hide("");
         if(SceneManager.active.type == SceneType.LOBBY)
         {
            ToolBar.hide();
            QuestTinyPanel.instance.hide();
         }
         if(SceneManager.active.type == SceneType.HOME)
         {
            HomePanel.hide();
         }
         this.updateView();
         LayerManager.stage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         this.layIcons();
      }
      
      private function layIcons() : void
      {
         if(this)
         {
            this.x = 118 - (1200 - LayerManager.stage.stageWidth) + 118 / 2 * (LayerManager.stage.stageWidth / 1200);
            this.y = 98 - (660 - LayerManager.stage.stageHeight);
         }
      }
      
      private function tweenDialog() : void
      {
         var _loc1_:Number = this.x;
         var _loc2_:Number = this.y;
         var _loc3_:int = int(MathUtil.randomRegion(1,4));
         if(_loc3_ == 1)
         {
            this.x = -this.width;
            this.alpha = 0.3;
            TweenMax.to(this,0.5,{
               "x":_loc1_,
               "alpha":1
            });
         }
         else if(_loc3_ == 2)
         {
            this.x = LayerManager.stage.stageWidth;
            this.alpha = 0.3;
            TweenMax.to(this,0.5,{
               "x":_loc1_,
               "alpha":1
            });
         }
         else if(_loc3_ == 3)
         {
            this.y = LayerManager.stage.stageHeight;
            this.alpha = 0.3;
            TweenMax.to(this,0.5,{
               "y":_loc2_,
               "alpha":1
            });
         }
      }
      
      private function hideInstance() : void
      {
         var _loc1_:MovieClip = null;
         this._isShowing = false;
         DisplayObjectUtil.removeAllChildren(this._functionUnitSp);
         DisplayObjectUtil.removeFromParent(this);
         LayerManager.resetOperation();
         if(SceneManager.active.type == SceneType.LOBBY)
         {
            ToolBar.show();
            QuestTinyPanel.instance.show();
         }
         if(SceneManager.active.type == SceneType.HOME)
         {
            HomePanel.show();
         }
         for each(_loc1_ in this._emotionList)
         {
            DisplayUtil.removeForParent(_loc1_);
         }
         LayerManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         this._emotionList = null;
      }
      
      private function updateView() : void
      {
         this.updateNpcPreview();
         this.updateContent();
         if(this._nodeIndex == this._nodeArr.length - 1)
         {
            this.showLabelBtn();
         }
         else
         {
            this.showNextNodeBtn();
         }
      }
      
      private function updateNpcPreview() : void
      {
         this._npcPreview.update(this._npcName,this._npcId,int(this._nodeArr[this._nodeIndex][0]));
      }
      
      private function updateContent() : void
      {
         var _loc1_:Object = new Object();
         _loc1_["name"] = "<font color=\'#FFFF99\' size=\'14\'>" + ActorManager.actorInfo.nick + "</font>";
         var _loc2_:* = replacePlayerName(String(this._nodeArr[this._nodeIndex][1]));
         _loc2_ = String(Util.replaceVariables(_loc2_,_loc1_));
         _loc2_ = "<font color=\'#52E5F9\' size=\'14\'>" + _loc2_ + "</font>";
         this._contentTxt.htmlText = _loc2_;
         this._contentTxt.y = 440;
         this._contentTxt.defaultTextFormat = this._contentFormat;
         this._contentTxt.height = 40;
         if(this._contentTxt.numLines >= 2)
         {
            this._contentTxt.y = 433;
            this._contentTxt.height = 60;
         }
         else
         {
            this._contentTxt.y = 440;
         }
         this._numLines = this._contentTxt.numLines;
         this.checkFaces(this._contentTxt);
      }
      
      public function checkFaces(param1:TextField) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc12_:uint = 0;
         var _loc13_:MovieClip = null;
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         _loc2_ = param1.htmlText;
         var _loc7_:RegExp = /\/:[0-9]{2}/g;
         if((_loc6_ = _loc2_.match(_loc7_)).length == 0)
         {
            return;
         }
         param1.htmlText = _loc2_.replace(_loc7_,"     ");
         var _loc8_:uint = 0;
         _loc3_ = param1.text;
         while(1)
         {
            _loc4_.push(_loc3_.indexOf("     ",_loc8_));
            if(_loc4_[_loc4_.length - 1] == -1)
            {
               _loc4_.pop();
               break;
            }
            _loc8_ = _loc4_[_loc4_.length - 1] + 1;
         }
         var _loc9_:uint = 0;
         var _loc10_:Number = param1.height;
         while(_loc9_ < _loc4_.length)
         {
            _loc5_.push(param1.getCharBoundaries(_loc4_[_loc9_]));
            _loc9_++;
         }
         _loc6_ = _loc6_.reverse();
         _loc5_ = _loc5_.reverse();
         this._emotionList = Vector.<MovieClip>([]);
         var _loc11_:uint = 0;
         while(_loc11_ < _loc6_.length)
         {
            if(_loc5_[_loc11_] != null)
            {
               _loc12_ = uint(_loc6_[_loc11_].substr(2,2));
               (_loc13_ = UIManager.getMovieClip("UI_Emotion" + _loc12_)).name = "UI_Emotion" + _loc12_;
               _loc13_.scaleX = _loc13_.scaleY = 0.7;
               _loc13_.x = _loc5_[_loc11_].x + 355;
               _loc13_.y = _loc5_[_loc11_].y + 444;
               if(_loc5_[_loc11_].y > 20)
               {
                  this.createFormat(11,_loc13_);
               }
               else
               {
                  this.createFormat(5,_loc13_);
               }
               this.addChild(_loc13_);
               this._emotionList.push(_loc13_);
               _loc13_ = null;
               _loc11_++;
            }
         }
         _loc7_ = null;
         _loc6_ = null;
         _loc5_ = null;
         _loc4_ = null;
         _loc3_ = null;
         _loc2_ = null;
      }
      
      private function createFormat(param1:uint, param2:MovieClip) : void
      {
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.size = 14;
         _loc3_.color = 5432825;
         _loc3_.font = "_sans";
         _loc3_.leading = param1;
         this._contentTxt.defaultTextFormat = _loc3_;
         if(param1 == 11)
         {
            this._contentTxt.y = 433;
         }
         else if(this._numLines == 1)
         {
            param2.y += 7;
         }
      }
      
      private function showNextNodeBtn() : void
      {
         this.clearAllBtn();
         this._nextNodeBtn.x = 760;
         this._nextNodeBtn.y = 530;
         addChild(this._nextNodeBtn);
      }
      
      private function showLabelBtn() : void
      {
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         if(this._closeArr.length <= 0)
         {
            this.showNextNodeBtn();
            return;
         }
         this.clearAllBtn();
         this._labelBtnVec = new Vector.<SimpleButton>();
         var _loc1_:int = int(this._closeArr.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = String(this._closeArr[_loc2_]);
            (_loc4_ = this.createReplyBtn(_loc3_)).addEventListener(MouseEvent.CLICK,this.onLabelBtnClick);
            this._labelBtnVec.push(_loc4_);
            _loc2_++;
         }
         this.layoutLabelBtn();
      }
      
      private function layoutLabelBtn() : void
      {
         var _loc1_:int = 790;
         var _loc2_:int = 520;
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc4_:int;
         var _loc5_:int = (_loc4_ = int(this._labelBtnVec.length)) - 1;
         while(_loc5_ >= 0)
         {
            _loc3_.push(_loc1_ - this._labelBtnVec[_loc5_].width);
            _loc1_ -= this._labelBtnVec[_loc5_].width + 10;
            _loc5_--;
         }
         _loc3_.reverse();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this._labelBtnVec[_loc5_].x = _loc3_[_loc5_];
            this._labelBtnVec[_loc5_].y = _loc2_;
            addChild(this._labelBtnVec[_loc5_]);
            _loc5_++;
         }
      }
      
      private function clearAllBtn() : void
      {
         var _loc1_:SimpleButton = null;
         if(this._labelBtnVec)
         {
            for each(_loc1_ in this._labelBtnVec)
            {
               DisplayObjectUtil.removeFromParent(_loc1_);
            }
            this._labelBtnVec = null;
         }
         DisplayObjectUtil.removeFromParent(this._nextNodeBtn);
      }
      
      private function onLabelBtnClick(param1:MouseEvent) : void
      {
         this.hideInstance();
         var _loc2_:int = this._labelBtnVec.indexOf(param1.currentTarget);
         if(this._closeHandlerArr != null && this._closeHandlerArr[_loc2_] != null)
         {
            this._closeHandlerArr[_loc2_]();
         }
      }
      
      private function isShowing() : Boolean
      {
         return this._isShowing;
      }
   }
}
