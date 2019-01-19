#!/bin/bash
# . path.sh

# replace headers
while read line; do
  IFS=' ' read -r -a array <<< $line
  filename=${array[0]}
  header=${array[1]}
  sed "1s/.*/$header/" ${NEO4J_DATA_DIR}/${filename}${NEO4J_DATA_POSTFIX} > tmp.csv && mv tmp.csv ${NEO4J_DATA_DIR}/${filename}${NEO4J_DATA_POSTFIX}
done < headers.txt

# replace labels with one starting with an uppercase letter
sed -i "s/|city$/|City/" "${NEO4J_DATA_DIR}/place${NEO4J_DATA_POSTFIX}"
sed -i "s/|country$/|Country/" "${NEO4J_DATA_DIR}/place${NEO4J_DATA_POSTFIX}"
sed -i "s/|continent$/|Continent/" "${NEO4J_DATA_DIR}/place${NEO4J_DATA_POSTFIX}"
sed -i "s/|company|/|Company|/" "${NEO4J_DATA_DIR}/organisation${NEO4J_DATA_POSTFIX}"
sed -i "s/|university|/|University|/" "${NEO4J_DATA_DIR}/organisation${NEO4J_DATA_POSTFIX}"

# convert each date of format yyyy-mm-dd to a number of format yyyymmddd
# find ${NEO4J_DATA_DIR} -name 'person_[0-9]*.csv' -exec sed -i "s#|\([0-9][0-9][0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9]\)|#|\1\2\3|#g" {} \;

# convert each datetime of format yyyy-mm-ddThh:mm:ss.mmm+0000
# to a number of format yyyymmddhhmmssmmm
# find ${NEO4J_DATA_DIR} -name *.csv -exec sed -i "s#|\([0-9][0-9][0-9][0-9]\)-\([0-9][0-9]\)-\([0-9][0-9]\)T\([0-9][0-9]\):\([0-9][0-9]\):\([0-9][0-9]\)\.\([0-9][0-9][0-9]\)+0000#|\1\2\3\4\5\6\7#g" \;
