@implementation BDWarLogic
//stolenResourcesByAttackingTroops:(NSDictionary *)attackingTroops defendedBy:(NSDictionary *)defendingTroops
-(void)attack{
	for (NSString* key in self.attackingTroops) {
		id value = [self.attackingTroops objectForKey:key];
		if(value){
			int a = soldiersKilledBy:[self.attackingTroops objectForKey:key] ofKind:/**/ defendedBy: [self.defendingTroops objectForKey:key.favouriteTarget];
			int b = soldiersKilledBy:[self.defendingTroops objectForKey:key.favouriteTarget] ofKind:/**/ defendedBy: [self.attackingTroops objectForKey:key];
			self.defendingTroops.key -= a;
			self.attackingTroops.key -= b;
		}	
	}
	if([[ckeckIfAllAreDead:self.attackingTroops] isEqual:YES]|| [[ckeckIfAllAreDead:self.defendingTroops] isEqual:YES]){
        NSLog(@"the war is over");
        if([[ckeckIfAllAreDead:self.attackingTroops] isEqual:YES]) {
			NSLog(@"defenders won");
		}
        else {
			NSLog(@"attackers won");
		}
    } else{
		int r, s = 0;
        for (NSString* key in self.defendingTroops) {
			value = [self.defendingTroops objectForKey:key];
			if(value) s++;
        }
        for (NSString* key in self.attackingTroops) {
			value = [self.attackingTroops objectForKey:key];
            if(value){
                r = arc4random_uniform(s - 1);
				a = soldiersKilledBy:[self.attackingTroops objectForKey:key] ofKind:/**/ defendedBy: [self.defendingTroops objectForKey:key.favouriteTarget];
				b = soldiersKilledBy:[self.defendingTroops objectForKey:key.favouriteTarget] ofKind:/**/ defendedBy: [self.attackingTroops objectForKey:key];
				self.defendingTroops.key -= a;
				self.attackingTroops.key -= b;
            }
        }
		int s1 = 0, s2 = 0;
      //  cout << "final standings: \n";
       /* for(i = 0; i < 10; i++){
            cout << attackers[i] << " " << defenders[i] << endl;
            s1 += (attack[i] + def[i] + health[i]) * attackers[i];
            s2 += (attack[i] + def[i] + health[i]) * defenders[i];
        }
        if(s1 > s2) cout <<" attackers won";
        else cout << "def won";
	}*/
}

-(NSInteger)soldiersKilledBy:(NSInteger *)amountOfAttackingSoldiers ofKind:(BDUnit *)attackingTroopsType defendedBy:(NSInteger *)amountOfDefendingSoldiers ofKind:(BDUnit *)defendingTroopsType{
	float rap = amountOfAttackingSoldiers / amountOfDefendingSoldiers;
	float a = amountOfDefendingSoldiers / rap;
	if ((defendingTroopsType.defense - rap * attackingTroopsType.attack) < defendingTroopsType.life * -1){
		return amountOfDefendingSoldiers;
	}
	else if ((defendingTroopsType.defense - rap * attackingTroopsType.attack) < 0){
		return (((defendingTroopsType.defense - rap * attackingTroopsType.attack) * -1) / defendingTroopsType.life) * a;
	}
	else return 0;
}

-(bool)ckeckIfAllAreDead:(NSDictionary *)troops{
	for (NSString* key in troops]){
		id value = [troops objectForKey:key];
		if(value){
			return 1;
		}
	}
	return 0;
}

@end