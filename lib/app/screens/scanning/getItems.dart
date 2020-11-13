class GetItems {


  static num findTotalHT(List lines){

    RegExp totalExp = new RegExp(r"[Tt][Oo][Tt][Aa][Ll][H][T]|[Tt][Oo][Tt][Aa][Ll][H][o][r][s][T][a][x][e]");
     RegExp moneyExp = new RegExp(r"([0-9]{1,}\.[0-9]{2,3}\t([Dd][Tt]|£))");


    for(int i = lines.length-1; i >= 0; i--){
        if(totalExp.hasMatch(lines[i]) && moneyExp.hasMatch(lines[i])){
            num total = num.parse(moneyExp.stringMatch(lines[i]).toString());
            return total;
        }
       
    }
    return 0;
  }


  static num findTax(List lines){

    RegExp taxExp = new RegExp(r"[Tt][Aa][Xx][Dd][Uu][Ee]");
     RegExp moneyExp = new RegExp(r"([0-9]{1,3}\.[0-9]{2})");


    for(int i = lines.length-1; i >= 0; i--){
        if(taxExp.hasMatch(lines[i]) && moneyExp.hasMatch(lines[i])){
            num lineCost = num.parse(moneyExp.stringMatch(lines[i]).toString());
            return lineCost;
        }
    }
    return null;
  }

  static String findMatricule(List lines){

    RegExp matExp = new RegExp(r"([0-9]{7}[a-zA-Z]{3}[0-9]{3})");
     


    for(int i = lines.length-1; i >= 0; i--){
        if(matExp.hasMatch(lines[i]) ){
            String matricule =matExp.stringMatch(lines[i]).toString();
            return matricule;
        }
    }
    return '';
  }

  static String findAddress(List lines){

    RegExp addressExp = new RegExp(r"^[A-Z].*\s[aA-zZ].*");
    RegExp addr = new RegExp(r"[A][d][r][e][s][s][e]");
    RegExp test = RegExp(r"(Rue|Avenue|Complexe)\s[aA-zZ].*");


    for(int i = lines.length-1; i >= 0; i--){
        if(test.hasMatch(lines[i])){
            String address =  lines[i].toString(); //.stringMatch(lines[i]).toString(); 
            return address;
        }
    }
    return 'address not found';
  }


  /*static String testAddress(String line){

    RegExp addressExp = new RegExp(r"^[A-Z].*\s[aA-zZ].*");
    RegExp addr = new RegExp(r"[A][d][r][e][s][s][e]");

        if(addressExp.hasMatch(line)){
          print("after");
            String address = line;
            return address;
        
    }
    return "non match";
  }*/


  static String findEmail(List lines){

    
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);

    for(int i = lines.length-1; i >= 0; i--){
        if(regex.hasMatch(lines[i])){
            String address =lines[i].toString(); 
            return address;
        }
    }
    return 'email not  found';
  }


  static String findName(List lines){

    
    
    RegExp regex = new RegExp(r"^[A-Z][A-Z]*");

    for(int i = lines.length-1; i >= 0; i--){
        if(regex.hasMatch(lines[i])){
            String name =lines[i].toString(); 
            return name;
        }
    }
    return 'name not found';
  }



  


}