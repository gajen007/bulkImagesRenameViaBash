echo "This script will rename all png files with a prefix that you prefer !"
echo "Example: Imagine you have two (or more) png images as dgyt.png and hjui.png"
echo "Those will be renamed as image_1.png, image_2.png etc..."
echo "Here image_ is the prefix you will decide"
echo "Hence this script will replace all the spaces in image files by underscores, before the renaming!"
#ask the prefix from user
echo "Enter the prefix"

#get the prefix and assign it to a variable
read prfx

#getting png files' names into an array
#pngFiles=($(ls *.png))
pngFiles=(*.png)

#get the number of mp4 files by counting that array's length
filesCount=${#pngFiles[@]}

#inform the user
echo "Found ${filesCount} png file(s) in this folder!"

#confirm with user by getting user-input
echo "Ready to rename them with your prefix ${prfx} ? (Y/N)"

#get confirmation
read confirmed

#validate user-input by 'if-else'
if [[ $confirmed = "Y" ]]
then
	for (( i=0;i<$filesCount;i++)); do
		singleFile="${pngFiles[$i]}"
		trimmed=${singleFile// /\_}
		mv "${singleFile}" "${trimmed}"
		if [ $? -eq 0 ]; then
			echo "renamed ${singleFile} as ${trimmed} !"
			number=$(($i + 1))
			newName="image_${number}.png"
			mv "${trimmed}" "${newName}"
			if [ $? -eq 0 ]; then
				echo "${trimmed} is renamed as ${newName}!"
			else
				echo "Unable to rename ${trimmed}; Skipped this file!"
			fi
		else
			echo "Unable to replace spaces in ${singleFile}; Skipped this file!"
		fi
	done
else
	echo "Operation cancelled!"
fi