FILE_NAME=ActionsGradleDemo-$APP_VERSION

# create installers and runtime (options are set in build.gradle)
echo "creating installers and runtime"
./gradlew jpackage


# create fat jar of project (see build.gradle)
echo "creating jar"
./gradlew fatJar

echo "creating releases folder"
mkdir ./build/releases/

echo "zipping runtime folder"
tar -czf ./build/releases/$FILE_NAME-linux-bin.tar.gz ./build/image/


echo "creating run file for other linux distributions"
mkdir ./builders/linux-installer/application
mv ./build/image/* ./builders/linux-installer/application
makeself ./builders/linux-installer/ $FILE_NAME-linux.run "Description" ./install.sh

echo "moving files to releases"
mv ./build/jpackage./$FILE_NAME* ./build/releases/
mv ./build/libs/$FILE_NAME.jar ./build/releases/$FILE_NAME-linux.jar
mv ./builders/linux-installer/*.run ./build/releases

