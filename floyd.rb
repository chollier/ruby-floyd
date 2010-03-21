#!/usr/bin/env ruby

ARGV.each do |a|
  (a == "-v") ? $verbose = 1 : $verbose = 0
  if a == "-h"
    puts "Usage : ./floyd.rb [options]"
    puts "Options :"
    puts "  -v : verbose mode"
    puts "  -h : prints this message"
    puts "please read the source code to know how to use this script :)"
    exit
  end
end


class Floyd
  
  #notre constructeur, on initialise la matrice des predecesseurs ici
  def initialize(graph = Array.new, pre = Array.new)
    # les variables avec des @ avant sont des attributs de notre objet.
    @graph = graph
    @pre = pre
    #pour 1 à n, on remplit notre matrice des prédecesseurs
    graph.each_index do |i|
      pre[i] = Array.new
      graph.each_index do |j|
        #on utilise i+1 car notre index commence à 0 sinon.
        pre[i][j] = i+1 
      end
    end
  end
  
  #application de l'algorithme de floyd
  def traitement
    @graph.each_index do |k|
      @graph.each_index do |i|
        @graph.each_index do |j|
          if (@graph[i][j] == "Ø") && (@graph[i][k] != "Ø" && @graph[k][j] != "Ø")
            @graph[i][j] = @graph[i][k]+@graph[k][j]
            @pre[i][j] = @pre[k][j]
          elsif (@graph[i][k] != "Ø" && @graph[k][j] != "Ø") && (@graph[i][j] > @graph[i][k]+@graph[k][j])
            @graph[i][j] = @graph[i][k]+@graph[k][j]
            @pre[i][j] = @pre[k][j]
          end
        end
      end
      #cela nous permet d'afficher chacune des itérations de k
      if $verbose == 1
        puts "\nk = #{k+1}"
        output
      end
    end
  end
  
  #permet de gérer l'affichage de nos matrices
  def output
    puts "###############"
    puts "Matrice A :"
    @graph.each_index do |i|
        #la fonction join nous permet d'qfficher online les éléments de notre tableau en précisant le separateur
        puts @graph[i].join(" | ")
    end
    puts "###############"
    puts "Matrice P :"
    @pre.each_index do |i|
        puts @pre[i].join(" | ")
    end
    puts "\n"
  end
  
end

#graph est notre tableau de tableaux representant la matrice de valuation. On utilise ø pour representer plus l'infini
graph = [[0, 3, 11, 17, 16, "Ø", 20, "Ø"], [3, 0, 5, "Ø", "Ø", "Ø", "Ø", "Ø"], [11, 5, 0, "Ø", 6, "Ø", 7, "Ø"], [17, "Ø", "Ø", 0, 3, "Ø", "Ø", 9], [16, "Ø", 6, 3, 0, 7, 6, "Ø"], ["Ø", "Ø", "Ø", "Ø", 7, 0, "Ø", 4], [20, "Ø", 7, "Ø", 6, "Ø", 0, 11], ["Ø", "Ø", "Ø", 9, "Ø", 4, 11, 0]]

#on instancie notre objet avec en argument notre matrice
objet = Floyd.new(graph)
#on affiche une première fois les deux matrices avant tout traitement
puts "Matrice d'origine :\n"
objet.output
#on lance le traitement ainsi que l'affichage à chaque itération si -v
objet.traitement
#on affiche notre résultat final.
puts "Matrice finale :\n"
objet.output
