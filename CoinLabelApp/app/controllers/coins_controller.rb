class CoinsController < ApplicationController
  def index 
    @coins = Coin.all
  end
  
  
  def print
    @coins = Coin.all
    
    @qrcodes = Array.new
    
    for index in 0 ... @coins.size
      @qrcodes[index] = generateQrCode(@coins[index])
    end
    
  end
  def new
    @coin = Coin.new
  end
  def edit
    @coin = Coin.find(params[:id])
    @img = generateQrCode(@coin)
  end
  def duplicate
    old_coin = Coin.find(params[:id])
    new_coin = old_coin.dup
    
    if new_coin.save
      redirect_to '/coins'
    end
  end
  def create 
    @coin = Coin.new(coin_params) 
    if @coin.save 
      redirect_to coin_path(@coin)
    else 
      render 'new' 
    end 
  end
  def update
    @coin = Coin.find(params[:id])
    if @coin.update(coin_params)
      redirect_to '/coins'
    else
      render 'edit'
    end
  end
  def destroy
    @coin = Coin.find(params[:id])
    if @coin.destroy
      redirect_to coins_path
    end
  end
  def clear
    Coin.delete_all
    redirect_to coins_path
  end
  def fastinput
    @coin = Coin.new(coin_params)
    
    lines = @coin.fastinput.split("\n")
    
    lines.each { |l|
      value = getvalue("Years", l)
      if (value == nil)
        value = getvalue("Year", l)
        if (value != nil)
          @coin.date = value
        end
      end
      
      value = getvalue("Country", l)
      if (value != nil)
        @coin.country = value
      end
      
      value = getvalue("Metal", l)
      if (value != nil)
        @coin.composition = value
      end
      
      value = getvalue("References", l)
      if (value != nil)
        @coin.catalog_no = value.delete("#")
      end
      
      value = getvalue("Value", l)
      if (value != nil)
        bracketindex = value.index("(")
        if (bracketindex == nil) 
          @coin.denomination = value
        else
          @coin.denomination = value[0, value.index("(")]
        end
      end
      
      value = getvalue("Metal", l)
      if (value != nil)
        @coin.composition = value
      end
      
      value = getvalue("Weight", l)
      if (value != nil)
        @coin.mass = value
      end
      
      value = getvalue("Diameter", l)
      if (value != nil)
        @coin.diameter = value
      end
      
      value = getvalue("Thickness", l)
      if (value != nil)
        @coin.thickness = value
      end
      
      value = getvalue("Shape", l)
      if (value != nil)
        @coin.shape = value
      end
      
      value = getvalue("Orientation", l)
      if (value != nil)
        @coin.orientation = value
      end
    }
    
    #save coin
    if @coin.save 
      redirect_to coin_path(@coin)
    else 
      render 'new' 
    end 
  end
private 
  def coin_params 
    params.require(:coin).permit(:content,
      :country,
      :date,
      :denomination,
      :grade,
      :notes,
      :condition_notes,
      :mintage,
      :catalog_no,
      :other_notes,
      :diameter,
      :composition,
      :mass,
      :thickness,
      :shape,
      :orientation,
      :qrcode,
      :fastinput)
  end
  
  def generateQrCode(coin)
    toencode = ""
    
    toencode = stringBuilder(toencode, "", coin.country)
    toencode = stringBuilder(toencode, "", coin.denomination)
    toencode = stringBuilder(toencode, "", coin.date)
    toencode = stringBuilder(toencode, "", coin.notes)
    #toencode = stringBuilder(toencode, "Mintage", coin.mintage)
    toencode = stringBuilder(toencode, "", coin.grade)
    #toencode = stringBuilder(toencode, "", coin.condition_notes)
    toencode = stringBuilder(toencode, "", coin.catalog_no)
    #toencode = stringBuilder(toencode, "Diameter", coin.diameter)
    #toencode = stringBuilder(toencode, "Thickness", coin.thickness)
    #toencode = stringBuilder(toencode, "Shape", coin.shape)
    #toencode = stringBuilder(toencode, "Composition", coin.composition)
    #toencode = stringBuilder(toencode, "Mass", coin.mass)
    #toencode = stringBuilder(toencode, "Orientation", coin.orientation)
    toencode = stringBuilder(toencode, "", coin.other_notes)
    
    
    qrcode = RQRCode::QRCode.new(toencode)
    
    
    
    image = qrcode.as_png
    return image
  end
  
  def stringBuilder(string, tag, concat)
    if (string == nil)
      string = ""
    end
    
    if (concat != nil && concat.length > 0)
      if (tag != nil && tag.length > 0)
        string = string + tag + ": "
      end
      string = string + concat + "\n"
    end
    return string
  end
  
  
  def getvalue(tag, line)
    i = line.index(tag)
    value = nil
    if i != nil
      value = line[i + tag.length, line.length-1].lstrip
    end
    return value
  end
  
end
