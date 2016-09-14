function stringname=getridofCharacters(stringname,characterCollection)
    stringname(ismember(stringname,characterCollection)) = [];