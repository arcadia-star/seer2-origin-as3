package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.sound.SoundManager;
   import com.taomee.seer2.core.utils.NumberUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.media.SoundChannel;
   
   public class PipeAnimation extends BaseAniamationInteractive
   {
       
      
      private var _npc:MovieClip;
      
      private var _pipeVec_1:Vector.<MovieClip>;
      
      private var _pipeVec_2:Vector.<MovieClip>;
      
      private var _tryAgainBtn:SimpleButton;
      
      private var _cancelBtn:SimpleButton;
      
      private var _tipMC:MovieClip;
      
      private var _answerVec:Vector.<int>;
      
      private var _pipeClick:int;
      
      private var playCnt:int;
      
      private var soundChannel:SoundChannel;
      
      private var _isPipeClick:Boolean = false;
      
      public function PipeAnimation()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         SoundManager.backgroundSoundEnabled = false;
         this._tipMC = _animation["tipMC"];
         this._npc = _animation["npc"];
         this._pipeVec_1 = new Vector.<MovieClip>();
         this._pipeVec_2 = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._pipeVec_1.push(_animation["m1_" + _loc1_]);
            this._pipeVec_2.push(_animation["m2_" + _loc1_]);
            _loc1_++;
         }
         this._tryAgainBtn = _animation["tryAgainBtn"];
         this._cancelBtn = _animation["cancelBtn"];
         this.initEventListener();
         this.reset();
      }
      
      private function initEventListener() : void
      {
         this._tryAgainBtn.addEventListener(MouseEvent.CLICK,this.onTryAgain);
         this._cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      private function reset() : void
      {
         this._answerVec = Vector.<int>(NumberUtil.randomArrFromArr([0,1,2,3,4,5,6],NumberUtil.random(3,5)));
         this._tipMC.gotoAndStop(1);
         this._npc.gotoAndStop(1);
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._pipeVec_1[_loc1_].gotoAndStop(1);
            this._pipeVec_2[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
         this._tryAgainBtn.visible = false;
         this._cancelBtn.visible = false;
         this.gameStart();
      }
      
      private function gameStart() : void
      {
         this._npc.gotoAndStop(2);
         this.playNpc(2,function():void
         {
            playCnt = 0;
            palyPipe(function():void
            {
               _npc.gotoAndStop(3);
               MovieClipUtil.playMc(_tipMC,0,_tipMC.totalFrames,function():void
               {
                  openEventListener();
                  _tipMC.gotoAndStop(1);
               },true);
               playNpc(3,null);
            });
         });
      }
      
      private function palyPipe(param1:Function) : void
      {
         var mc:MovieClip = null;
         var fun:Function = param1;
         if(this.playCnt < this._answerVec.length)
         {
            mc = this._pipeVec_1[this._answerVec[this.playCnt]];
            this.soundChannel = getSound("sound_" + (this._answerVec[this.playCnt] + 1)).play();
            MovieClipUtil.playMc(mc,0,mc.totalFrames,function():void
            {
               soundChannel.stop();
               mc.gotoAndStop(1);
               ++playCnt;
               if(playCnt >= _answerVec.length)
               {
                  fun();
                  fun = null;
               }
               else
               {
                  palyPipe(fun);
               }
            });
         }
      }
      
      private function openEventListener() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._pipeVec_2[_loc1_].buttonMode = true;
            this._pipeVec_2[_loc1_].addEventListener(MouseEvent.CLICK,this.onPipeClick);
            _loc1_++;
         }
         this._pipeClick = 0;
      }
      
      private function closeEventListener() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._pipeVec_2[_loc1_].buttonMode = false;
            this._pipeVec_2[_loc1_].removeEventListener(MouseEvent.CLICK,this.onPipeClick);
            _loc1_++;
         }
      }
      
      private function onPipeClick(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var answer:int = 0;
         var evt:MouseEvent = param1;
         if(this._isPipeClick)
         {
            return;
         }
         this._isPipeClick = true;
         mc = evt.currentTarget as MovieClip;
         answer = int(mc.name.substr(3,1));
         this.soundChannel = getSound("sound_" + (answer + 1)).play(0);
         MovieClipUtil.playMc(mc,0,mc.totalFrames - 2,function():void
         {
            _isPipeClick = false;
            soundChannel.stop();
            if(_answerVec[_pipeClick] == answer)
            {
               ++_pipeClick;
               mc.gotoAndStop(31);
               if(_pipeClick >= _answerVec.length)
               {
                  _isSuccess = true;
                  dispose();
               }
            }
            else
            {
               mc.gotoAndStop(30);
               gameOver();
            }
         });
      }
      
      private function gameOver() : void
      {
         this.closeEventListener();
         this._npc.gotoAndStop(4);
         this.playNpc(4,function():void
         {
            _tryAgainBtn.visible = true;
            _cancelBtn.visible = true;
         });
      }
      
      private function playNpc(param1:int, param2:Function) : void
      {
         var frame:int = param1;
         var fun:Function = param2;
         this._npc.addFrameScript(frame - 1,function():void
         {
            _npc.addFrameScript(frame - 1,null);
            var _loc1_:MovieClip = _npc["mc"];
            MovieClipUtil.playMc(_loc1_,0,_loc1_.totalFrames,fun);
         });
      }
      
      private function onTryAgain(param1:MouseEvent) : void
      {
         this.reset();
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         _isSuccess = false;
         this.dispose();
      }
      
      override public function dispose() : void
      {
         SoundManager.backgroundSoundEnabled = true;
         this.closeEventListener();
         this._tryAgainBtn.removeEventListener(MouseEvent.CLICK,this.onTryAgain);
         this._cancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancel);
         super.dispose();
      }
   }
}
