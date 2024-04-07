package com.taomee.seer2.app.arena.util {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.cmd.ArenaResourceLoadCMD;
import com.taomee.seer2.app.arena.data.FighterBuffInfo;

public class AngerCorrecter {

    private static var thisAngerCorrecter:AngerCorrecter = new AngerCorrecter();


    private var myFighter:Fighter;

    private var hostileFighter:Fighter;

    private var myBuffInfoVec:Vector.<FighterBuffInfo>;

    private var hostileBuffInfoVec:Vector.<FighterBuffInfo>;

    private var myAnger:uint;

    private var hostileAnger:uint;

    private var sumOfTrait:int = 0;

    private var myAngerBuffArr:Array;

    private var hostileAngerBuffArr:Array;

    public function AngerCorrecter() {
        super();
    }

    public static function getInstance():AngerCorrecter {
        return thisAngerCorrecter;
    }

    public function angerCalulater(param1:Fighter, param2:Fighter):void {
        myAngerBuffArr = [0, 0, 0, 0, 0];
        hostileAngerBuffArr = [0, 0, 0, 0, 0];
        this.myFighter = param1;
        this.hostileFighter = param2;
        myAnger = uint(myFighter.fighterInfo.fightAnger);
        hostileAnger = uint(hostileFighter.fighterInfo.fightAnger);
        if (hostileFighter.fighterInfo.fightBuffInfoVec.length == 0) {
            myAnger += 15;
            hostileAnger += 15;
        } else {
            inputBuffData();
            startCalulater();
        }
        this.myFighter.updateAnger(myAnger);
        this.hostileFighter.updateAnger(hostileAnger);
        myFighter = null;
        hostileFighter = null;
        myAngerBuffArr = null;
        hostileAngerBuffArr = null;
        this.myBuffInfoVec = null;
        this.hostileBuffInfoVec = null;
    }

    private function startCalulater():void {
        if (ArenaResourceLoadCMD.theSide == 1) {
            myCalulater();
            hostileFighterCalulater();
            myAnger += 15;
            if (myAngerBuffArr[4] != 0) {
                tianXuan(true);
            }
            hostileAnger += 15;
            if (hostileAngerBuffArr[4] != 0) {
                tianXuan(false);
            }
        } else {
            hostileFighterCalulater();
            myCalulater();
            hostileAnger += 15;
            if (hostileAngerBuffArr[4] != 0) {
                tianXuan(false);
            }
            myAnger += 15;
            if (myAngerBuffArr[4] != 0) {
                tianXuan(true);
            }
        }
    }

    private function myCalulater():void {
        if (myAngerBuffArr[0] != 0 && !this.hostileFighter.isDead()) {
            reduceAngerStar(true, myAngerBuffArr[0]);
        }
        if (myAngerBuffArr[1] != 0) {
            increaseAngerStar(true, myAngerBuffArr[1]);
        }
        if (myAngerBuffArr[2] != 0) {
            thunderSea(true);
        }
        if (myAngerBuffArr[3] != 0) {
            ImmerseRain(true);
        }
    }

    private function hostileFighterCalulater():void {
        if (hostileAngerBuffArr[0] != 0 && !this.myFighter.isDead()) {
            reduceAngerStar(false, hostileAngerBuffArr[0]);
        }
        if (hostileAngerBuffArr[1] != 0) {
            increaseAngerStar(false, hostileAngerBuffArr[1]);
        }
        if (hostileAngerBuffArr[2] != 0) {
            thunderSea(false);
        }
        if (hostileAngerBuffArr[3] != 0) {
            ImmerseRain(false);
        }
    }

    private function sumTrait(side:Boolean):void {
        sumOfTrait = 0;
        if (!(myFighter.isDead() || hostileFighter.isDead())) {
            if (side && this.hostileFighter.fighterTurnResultInfo != null) {
                hostileFighter.fighterTurnResultInfo.changedAtk = hostileFighter.fighterTurnResultInfo.changedAtk > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedAtk;
                hostileFighter.fighterTurnResultInfo.changedDefence = hostileFighter.fighterTurnResultInfo.changedDefence > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedDefence;
                hostileFighter.fighterTurnResultInfo.changedSpecialAtk = hostileFighter.fighterTurnResultInfo.changedSpecialAtk > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpecialAtk;
                hostileFighter.fighterTurnResultInfo.changedSpecialDefence = hostileFighter.fighterTurnResultInfo.changedSpecialDefence > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpecialDefence;
                hostileFighter.fighterTurnResultInfo.changedSpeed = hostileFighter.fighterTurnResultInfo.changedSpeed > 2 ? 2 : hostileFighter.fighterTurnResultInfo.changedSpeed;
            } else if (this.myFighter.fighterTurnResultInfo != null) {
                myFighter.fighterTurnResultInfo.changedAtk = myFighter.fighterTurnResultInfo.changedAtk > 2 ? 2 : myFighter.fighterTurnResultInfo.changedAtk;
                myFighter.fighterTurnResultInfo.changedDefence = myFighter.fighterTurnResultInfo.changedDefence > 2 ? 2 : myFighter.fighterTurnResultInfo.changedDefence;
                myFighter.fighterTurnResultInfo.changedSpecialAtk = myFighter.fighterTurnResultInfo.changedSpecialAtk > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpecialAtk;
                myFighter.fighterTurnResultInfo.changedSpecialDefence = myFighter.fighterTurnResultInfo.changedSpecialDefence > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpecialDefence;
                myFighter.fighterTurnResultInfo.changedSpeed = myFighter.fighterTurnResultInfo.changedSpeed > 2 ? 2 : myFighter.fighterTurnResultInfo.changedSpeed;
            }
            if (this.hostileFighter.fighterTurnResultInfo != null) {
                this.sumOfTrait += this.hostileFighter.fighterTurnResultInfo.sum();
            }
            if (this.myFighter.fighterTurnResultInfo != null) {
                this.sumOfTrait += this.myFighter.fighterTurnResultInfo.sum();
            }
        }
    }

    private function inputBuffData():void {
        this.myBuffInfoVec = myFighter.fighterInfo.fightBuffInfoVec;
        this.hostileBuffInfoVec = hostileFighter.fighterInfo.fightBuffInfoVec;
        for each(var buff:FighterBuffInfo in myBuffInfoVec) {
            if (buff.buffId == 30006) {
                myAngerBuffArr[0] = buff.dummy2;
            } else if (buff.buffId == 11129) {
                myAngerBuffArr[1] = buff.dummy2;
            } else if (buff.buffId == 11891) {
                myAngerBuffArr[2] = 1;
            } else if (buff.buffId == 11900) {
                this.sumTrait(true);
                myAngerBuffArr[3] = 1;
            }
        }
        if (myFighter.fighterInfo.resourceId == 2542) {
            myAngerBuffArr[4] = 1;
        }
        for each(buff in hostileBuffInfoVec) {
            if (buff.buffId == 30006) {
                hostileAngerBuffArr[0] = buff.dummy2;
            } else if (buff.buffId == 11129) {
                hostileAngerBuffArr[1] = buff.dummy2;
            } else if (buff.buffId == 11891) {
                hostileAngerBuffArr[2] = 1;
            } else if (buff.buffId == 11900) {
                this.sumTrait(false);
                hostileAngerBuffArr[3] = 1;
            }
        }
        if (hostileFighter.fighterInfo.resourceId == 2542) {
            hostileAngerBuffArr[4] = 1;
        }
    }

    private function reduceAngerStar(side:Boolean, level:int):void {
        if (side) {
            hostileAnger = hostileAnger < level * 2 + 3 ? 0 : hostileAnger - (level * 2 + 3);
        } else {
            myAnger = myAnger < level * 2 + 3 ? 0 : myAnger - (level * 2 + 3);
        }
    }

    private function increaseAngerStar(side:Boolean, level:int):void {
        if (side) {
            myAnger += level * 2 + 3;
        } else {
            hostileAnger += level * 2 + 3;
        }
    }

    private function thunderSea(side:Boolean):void {
        if (side) {
            myAnger = 50;
        } else {
            hostileAnger = 50;
        }
    }

    private function ImmerseRain(side:Boolean):void {
        if (side) {
            myAnger += sumOfTrait * 5;
        } else {
            hostileAnger += sumOfTrait * 5;
        }
    }

    private function tianXuan(side:Boolean):void {
        if (side) {
            if (myAnger < 50) {
                myAnger += 20;
            } else if (myAnger >= 50) {
                myAnger -= 15;
            }
        } else if (hostileAnger < 50) {
            hostileAnger += 20;
        } else if (hostileAnger >= 50) {
            hostileAnger -= 15;
        }
    }
}
}
