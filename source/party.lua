function getParty()
  party = {}
  party.party_list = {}
  party.total_money = 400
  require("source/data/party_data")
  party.partydata = getPartyData()
  party.total_members = 0
  function party:getPartyList()
    return self.party_list
  end
  function party:getStat(party_id,stat)
    return self.party_list[party_id][stat]
  end
  function party:updateStat(party_id,stat,new_value)
    self.party_list[party_id][stat] = new_value
  end
  function party:createNewMember(name,class)
    self.total_members = self.total_members + 1
    index = 0
    if class == "Red Mage" then
       index = 1
    elseif class == "Black Mage" then
       index = 2
    end
    new_member = {}
    for k,v in pairs(self.partydata[index]) do
   new_member[k] = v
    end
    table.insert(self.party_list,new_member)
    self.party_list[#self.party_list].name = name
    new_member = nil
  --  bugdraw:addToDebug(  self.party_list[total_members],name.."-"..class,{"name","class","current_hp","current_mp"})
  end

  bugdraw:addToDebug(party,"Party",{"total_money"})
  return party
end
