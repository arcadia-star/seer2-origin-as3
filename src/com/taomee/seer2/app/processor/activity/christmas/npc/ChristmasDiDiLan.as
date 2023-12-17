package com.taomee.seer2.app.processor.activity.christmas.npc
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.activity.christmas.IChristmasNpc;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.taomee.utils.DisplayUtil;
   
   public class ChristmasDiDiLan implements IChristmasNpc
   {
       
      
      private var _npc:Mobile;
      
      private var _takePicMC:MovieClip;
      
      private var _picVec:Vector.<MovieClip>;
      
      private var _targetPicVec:Vector.<MovieClip>;
      
      private var _cameraMouse:MovieClip;
      
      private var _takePicTimeMC:MovieClip;
      
      private var _hasTakedPicCount:int;
      
      private var _res:ResourceLibrary;
      
      private var _didilanMC:MovieClip;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function ChristmasDiDiLan(param1:ResourceLibrary)
      {
         super();
         this._res = param1;
      }
      
      public function playAnimation() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("9/3"));
         MovieClipUtil.playFullScreen(url,function():void
         {
            initMouse();
            initNpc();
         },false);
      }
      
      private function initMouse() : void
      {
         DisplayObjectUtil.removeFromParent(this._mouseHint);
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 331;
         this._mouseHint.y = 295;
         LayerManager.topLayer.addChild(this._mouseHint);
      }
      
      public function initNpc() : void
      {
         var _loc1_:XML = <npc id="425" resId="425" name="迪迪兰" dir="1" width="25" height="50" pos="331,313" actorPos="334,325" path="">
												<eventHandler>
													<mouseOver>
														<HandlerShowNpcSlogan><![CDATA[像我这么拉轰的迪迪兰到哪里去找哟！]]></HandlerShowNpcSlogan>
													</mouseOver>
												</eventHandler>
										  </npc>;
         var _loc2_:NpcDefinition = new NpcDefinition(_loc1_);
         this._npc = MobileManager.createNpc(_loc2_);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
         this._hasTakedPicCount = 0;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DisplayObjectUtil.removeFromParent(this._mouseHint);
         NpcDialog.show(425,"迪迪兰",[[0,"亲爱哒!~~我知道你最最最好了！给我拍几张照片吧！我想做圣诞代言人！"]],[" 臭美兰……（拍吧）","一会再来找我吧！（不拍）"],[function():void
         {
            _npc.removeEventListener(MouseEvent.CLICK,onClick);
            var _loc1_:* = URLUtil.getActivityAnimation("9/didilanAnimation");
            QueueLoader.load(_loc1_,LoadType.SWF,onTakePicLoaded);
         }]);
      }
      
      private function onTakePicLoaded(param1:ContentInfo) : void
      {
         this._takePicMC = param1.content as MovieClip;
         this.processTakePic();
      }
      
      private function processTakePic() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         this._picVec = new Vector.<MovieClip>();
         this._targetPicVec = new Vector.<MovieClip>();
         var _loc1_:uint = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = this._takePicMC["targetDilan" + _loc1_];
            _loc2_.gotoAndStop(1);
            this._targetPicVec.push(_loc2_);
            _loc3_ = this._takePicMC["dilan" + _loc1_];
            _loc3_.visible = true;
            _loc3_.gotoAndPlay(1);
            this._picVec.push(_loc3_);
            _loc1_++;
         }
         this._cameraMouse = this._takePicMC["cameraMouse"];
         this._cameraMouse.addEventListener(Event.ENTER_FRAME,this.onCameraMove);
         this._cameraMouse.addEventListener(MouseEvent.CLICK,this.onTakePic);
         Mouse.hide();
         this._takePicTimeMC = this._takePicMC["timer"];
         this._takePicTimeMC.addEventListener(Event.ENTER_FRAME,this.onTakePicTimeEnd);
         this._takePicTimeMC.gotoAndPlay(1);
         LayerManager.focusOnTopLayer();
         LayerManager.topLayer.addChild(this._takePicMC);
      }
      
      private function onCameraMove(param1:Event) : void
      {
         this._cameraMouse.x = LayerManager.topLayer.mouseX;
         this._cameraMouse.y = LayerManager.topLayer.mouseY;
         this.setCameraMouseStatus();
      }
      
      private function setCameraMouseStatus() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._picVec.length)
         {
            if(this._picVec[_loc1_].visible && (this._cameraMouse["cameraArea"] as MovieClip).hitTestObject(this._picVec[_loc1_]))
            {
               this._cameraMouse.gotoAndStop(2);
               return;
            }
            _loc1_++;
         }
         this._cameraMouse.gotoAndStop(1);
      }
      
      private function onTakePic(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         while(_loc3_ < this._picVec.length)
         {
            if(this._picVec[_loc3_].visible && (this._cameraMouse["cameraArea"] as MovieClip).hitTestObject(this._picVec[_loc3_]))
            {
               _loc2_ = this._picVec[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_ != null)
         {
            ++this._hasTakedPicCount;
            this._picVec[_loc3_].visible = false;
            this._targetPicVec[_loc3_].gotoAndStop(2);
            if(this._hasTakedPicCount == 3)
            {
               this.takePicSuccess();
            }
         }
      }
      
      private function takePicSuccess() : void
      {
         this.clearTaksPic();
         Mouse.show();
         this._didilanMC = this._res.getMovieClip("didilanComplete");
         LayerManager.topLayer.addChild(this._didilanMC);
         this._didilanMC.x = this._npc.x + 150;
         this._didilanMC.y = this._npc.y - 30;
         this._npc.visible = false;
         InteractiveRewardManager.requestReward(55,function(param1:Parser_1060):void
         {
            var parser:Parser_1060 = param1;
            MovieClipUtil.playMc(_didilanMC,2,_didilanMC.totalFrames,function():void
            {
               if(parser.activityCount == 0)
               {
                  AlertManager.showAlert("哎哟！我们M5的礼物都被你拿光光了啦！明天再给你吧！");
               }
               else
               {
                  parser.showResult();
               }
               DisplayUtil.removeForParent(_didilanMC);
            });
         });
      }
      
      private function takePicFail() : void
      {
         this.clearTaksPic();
         Mouse.show();
         NpcDialog.show(425,"迪迪兰",[[0,"哼！我可是未来的圣诞代言人，你竟然不好好给我拍照！"]],["谁让你动来动去的……"],[function():void
         {
            _didilanMC = _res.getMovieClip("didilanComplete");
            LayerManager.topLayer.addChild(_didilanMC);
            _didilanMC.x = _npc.x + 150;
            _didilanMC.y = _npc.y - 30;
            _npc.visible = false;
            MovieClipUtil.playMc(_didilanMC,2,_didilanMC.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_didilanMC);
            });
         }]);
      }
      
      private function clearTaksPic() : void
      {
         LayerManager.resetOperation();
         this._takePicTimeMC.removeEventListener(Event.ENTER_FRAME,this.onTakePicTimeEnd);
         this._cameraMouse.removeEventListener(Event.ENTER_FRAME,this.onCameraMove);
         this._cameraMouse.removeEventListener(MouseEvent.CLICK,this.onTakePic);
         DisplayUtil.removeForParent(this._takePicMC);
      }
      
      private function onTakePicTimeEnd(param1:Event) : void
      {
         if(this._takePicTimeMC.currentFrame == this._takePicTimeMC.totalFrames)
         {
            this._takePicTimeMC.removeEventListener(Event.ENTER_FRAME,this.onTakePicTimeEnd);
            if(this._hasTakedPicCount < 3)
            {
               this.takePicFail();
            }
         }
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeFromParent(this._mouseHint);
         this._mouseHint = null;
         LayerManager.resetOperation();
         this._hasTakedPicCount = 0;
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClick);
            DisplayUtil.removeForParent(this._npc);
         }
         this._npc = null;
         var _loc1_:String = String(URLUtil.getActivityAnimation("9/TakePicAnimation"));
         QueueLoader.cancel(_loc1_,this.onTakePicLoaded);
         Mouse.show();
         DisplayUtil.removeForParent(this._didilanMC);
         DisplayUtil.removeForParent(this._takePicMC);
         this._didilanMC = null;
         this._takePicMC = null;
      }
   }
}
