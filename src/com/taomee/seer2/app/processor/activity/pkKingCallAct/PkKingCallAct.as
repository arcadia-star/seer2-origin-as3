package com.taomee.seer2.app.processor.activity.pkKingCallAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class PkKingCallAct
   {
      
      private static var _npc:Mobile;
      
      private static const FOR_LIST:Array = [250331,250332];
      
      private static const DAY_LIST:Array = [5125,5126];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([4064]);
      
      private static const FIGHT_INDEX:int = 1617;
      
      private static const MAP_LIST:Vector.<int> = Vector.<int>([132,810,520]);
      
      private static const GOAL_NUM:int = 5;
      
      private static const GAME_ID:int = 43;
      
      private static const NpcList:Array = [["缪斯",705,400],["布莱克",726,400],["卡修斯",761,400]];
      
      private static var _mapIndex:int;
      
      private static var _curGateIndex:int;
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
      
      private static var _leaveTime:int;
      
      private static var _talkState:Vector.<Boolean>;
      
      private static var _mouseHint:MouseClickHintSprite;
       
      
      public function PkKingCallAct()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(!isInAct())
         {
            return;
         }
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
      }
      
      private static function isInAct() : Boolean
      {
         var _loc1_:Boolean = false;
         if(DateUtil.isInTime(new Date(2015,5,30),new Date(2015,6,9,23,59,59)))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private static function onComplete(param1:SceneEvent = null) : void
      {
         if(MAP_LIST.indexOf(SceneManager.prevMapID) != -1)
         {
            dispose();
         }
         _mapIndex = MAP_LIST.indexOf(SceneManager.active.mapID);
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            ModuleManager.showAppModule("PkKingCallActPanel");
         }
         if(_mapIndex == -1)
         {
            return;
         }
         update();
      }
      
      private static function setFuncDisable() : void
      {
         if(_npc)
         {
            _npc.mouseEnabled = _npc.mouseChildren = false;
         }
      }
      
      private static function update(param1:Function = null) : void
      {
         var func:Function = param1;
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var info:DayLimitListInfo = param1;
               _par = par;
               _info = info;
               var i:int = 0;
               while(i < 3)
               {
                  if(!BitUtil.getBit(par.infoVec[0],i))
                  {
                     if(i == 0)
                     {
                        _curGateIndex = i;
                     }
                     if(i > 0 && Boolean(BitUtil.getBit(par.infoVec[0],i - 1)))
                     {
                        _curGateIndex = i;
                     }
                  }
                  i++;
               }
               removeNpc();
               if(_mapIndex != _curGateIndex)
               {
                  return;
               }
               Tick.instance.removeRender(onTimeUpdate);
               _leaveTime = info.getCount(DAY_LIST[1]) - TimeManager.getPrecisionServerTime();
               if(_leaveTime <= 0)
               {
                  if(info.getCount(DAY_LIST[0]) < GOAL_NUM)
                  {
                     addNpc();
                  }
               }
               else
               {
                  addNpc();
                  Tick.instance.addRender(onTimeUpdate,1000);
               }
               _talkState = Vector.<Boolean>([]);
               ServerBufferManager.getServerBuffer(ServerBufferType.PK_KING_CALL,function(param1:ServerBuffer):void
               {
                  var _loc2_:int = 0;
                  while(_loc2_ < 3)
                  {
                     _talkState.push(Boolean(param1.readDataAtPostion(_loc2_ + 1)));
                     _loc2_++;
                  }
                  if(func != null)
                  {
                     func();
                  }
               });
            });
         });
      }
      
      private static function onTimeUpdate(param1:int) : void
      {
         --_leaveTime;
         if(_leaveTime <= 0)
         {
            Tick.instance.removeRender(onTimeUpdate);
            update();
         }
      }
      
      private static function onGoFinish(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,MAP_LIST[1]);
      }
      
      private static function addNpc() : void
      {
         _npc = new Mobile();
         _npc.width = 82;
         _npc.height = 160;
         _npc.setPostion(new Point(610,510));
         _npc.resourceUrl = URLUtil.getNpcSwf(NpcList[_curGateIndex][1]);
         _npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         _npc.label = NpcList[_curGateIndex][0];
         _npc.labelImage.y = -_npc.height - 10;
         _npc.buttonMode = true;
         showMouseHintAtMonster(_npc);
         MobileManager.addMobile(_npc,MobileType.NPC);
         _npc.addEventListener(MouseEvent.CLICK,onNpc);
      }
      
      private static function onNpc(param1:MouseEvent) : void
      {
         talkHandle0();
         talkHandle1();
         talkHandle2();
      }
      
      private static function talkHandle0() : void
      {
         if(_curGateIndex == 0)
         {
            if(_talkState[_curGateIndex])
            {
               if(_leaveTime > 0)
               {
                  NpcDialog.show(705,"缪斯",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                  {
                     ModuleManager.showAppModule("PkKingCallActPanel");
                  }]);
               }
               else
               {
                  NpcDialog.show(705,"缪斯",[[0,"哼~石头剪刀布，五局三胜哦~战胜我才考虑来不来参加。"]],["来吧！","让我准备一下"],[function():void
                  {
                     ModuleManager.showAppModule("PkKingCallGameOnePanel",{"func":gameHandle});
                  }]);
               }
            }
            else
            {
               NpcDialog.show(400,"小赛尔",[[0,"缪斯！缪斯！最强王者争霸赛就要开始了，来参加嘛？"]],["雷伊他们都会来哟~"],[function():void
               {
                  NpcDialog.show(705,"缪斯",[[0,"哦？他们也要参赛？"]],["他们是三个队伍的领袖哦。"],[function():void
                  {
                     NpcDialog.show(705,"缪斯",[[0,"我也是战神，竟然不让我来领导队伍？！"]],[" 我这不是来邀请你成为他们的搭档嘛~"],[function():void
                     {
                        ServerBufferManager.updateServerBuffer(ServerBufferType.PK_KING_CALL,_curGateIndex + 1,1);
                        update(function():void
                        {
                           if(_leaveTime > 0)
                           {
                              NpcDialog.show(705,"缪斯",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                              {
                                 ModuleManager.showAppModule("PkKingCallActPanel");
                              }]);
                           }
                           else
                           {
                              NpcDialog.show(705,"缪斯",[[0,"哼~石头剪刀布，五局三胜哦~战胜我才考虑来不来参加。"]],["来吧！","让我准备一下"],[function():void
                              {
                                 ModuleManager.showAppModule("PkKingCallGameOnePanel",{"func":gameHandle});
                              }]);
                           }
                        });
                     }]);
                  }]);
               }]);
            }
         }
      }
      
      private static function gameHandle(param1:int) : void
      {
         var val:int = param1;
         SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            update();
            if(val == 1)
            {
               ModuleManager.showAppModule("PkKingCallActPanel");
            }
         },null,new SpecialInfo(1,val));
      }
      
      private static function talkHandle1() : void
      {
         if(_curGateIndex == 1)
         {
            if(_talkState[_curGateIndex])
            {
               if(_leaveTime > 0)
               {
                  NpcDialog.show(726,"布莱克",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                  {
                     ModuleManager.showAppModule("PkKingCallActPanel");
                  }]);
               }
               else
               {
                  NpcDialog.show(726,"布莱克",[[0,ActorManager.actorInfo.nick + "," + "来过两招，赢了我就勉强参加！"]],["来吧！","让我准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(FIGHT_INDEX);
                  }]);
               }
            }
            else
            {
               NpcDialog.show(400,"小赛尔",[[0,"布莱克！最强王者争霸赛就要开始了，来参加嘛？"]],["雷伊他们都会来哟~"],[function():void
               {
                  NpcDialog.show(726,"布莱克",[[0,"不要……"]],["别那么冷淡嘛，你可是战队领袖之一哦"],[function():void
                  {
                     NpcDialog.show(726,"布莱克",[[0,"不去……"]],["雷伊他们都会去哦，你不去他们会嘲笑你哦。"],[function():void
                     {
                        ServerBufferManager.updateServerBuffer(ServerBufferType.PK_KING_CALL,_curGateIndex + 1,1);
                        update(function():void
                        {
                           if(_leaveTime > 0)
                           {
                              NpcDialog.show(726,"布莱克",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                              {
                                 ModuleManager.showAppModule("PkKingCallActPanel");
                              }]);
                           }
                           else
                           {
                              NpcDialog.show(726,"布莱克",[[0,ActorManager.actorInfo.nick + "," + "来过两招，赢了我就勉强参加！"]],["来吧！","让我准备一下"],[function():void
                              {
                                 FightManager.startFightWithWild(FIGHT_INDEX);
                              }]);
                           }
                        });
                     }]);
                  }]);
               }]);
            }
         }
      }
      
      private static function talkHandle2() : void
      {
         if(_curGateIndex == 2)
         {
            if(_talkState[_curGateIndex])
            {
               if(_leaveTime > 0)
               {
                  NpcDialog.show(761,"卡修斯",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                  {
                     ModuleManager.showAppModule("PkKingCallActPanel");
                  }]);
               }
               else
               {
                  NpcDialog.show(761,"卡修斯",[[0,"不过，证明一下你够资格参赛吧，祖玛玩到1200分以上我才认可。我只跟最强的人一起比赛。"]],["哈！等着瞧！","我等会再来！"],[function():void
                  {
                     ModuleManager.showModule(URLUtil.getAppModule("MiniGameConsolePanel"),"正在打开小游戏...",{
                        "gameId":GAME_ID,
                        "gameOverFunc":function():void
                        {
                           ModuleManager.showAppModule("PkKingCallActPanel");
                        }
                     });
                  }]);
               }
            }
            else
            {
               NpcDialog.show(400,"小赛尔",[[0,"卡修斯~最强王者争霸赛就要开始了，来参加嘛？"]],[" 就差你一个了！"],[function():void
               {
                  NpcDialog.show(761,"卡修斯",[[0,"哈哈，那当然要来呀！"]],["（你果然比其他人爽快）"],[function():void
                  {
                     ServerBufferManager.updateServerBuffer(ServerBufferType.PK_KING_CALL,_curGateIndex + 1,1);
                     update(function():void
                     {
                        if(_leaveTime > 0)
                        {
                           NpcDialog.show(761,"卡修斯",[[0,"我累了，休息一下再战！"]],["我都没累呢！"],[function():void
                           {
                              ModuleManager.showAppModule("PkKingCallActPanel");
                           }]);
                        }
                        else
                        {
                           NpcDialog.show(761,"卡修斯",[[0,"不过，证明一下你够资格参赛吧，祖玛玩到1200分以上我才认可。我只跟最强的人一起比赛。"]],["哈！等着瞧！","我等会再来！"],[function():void
                           {
                              ModuleManager.showModule(URLUtil.getAppModule("MiniGameConsolePanel"),"正在打开小游戏...",{
                                 "gameId":GAME_ID,
                                 "gameOverFunc":function():void
                                 {
                                    ModuleManager.showAppModule("PkKingCallActPanel");
                                 }
                              });
                           }]);
                        }
                     });
                  }]);
               }]);
            }
         }
      }
      
      private static function removeNpc() : void
      {
         if(_npc)
         {
            removeMouseHint();
            _npc.removeEventListener(MouseEvent.CLICK,onNpc);
            DisplayUtil.removeForParent(_npc);
            _npc = null;
         }
      }
      
      private static function showMouseHintAtMonster(param1:Sprite) : void
      {
         _mouseHint = new MouseClickHintSprite();
         _mouseHint.y = -180;
         _mouseHint.x = 0;
         param1.addChild(_mouseHint);
      }
      
      private static function removeMouseHint() : void
      {
         DisplayUtil.removeForParent(_mouseHint);
         _mouseHint = null;
      }
      
      private static function dispose() : void
      {
      }
   }
}
