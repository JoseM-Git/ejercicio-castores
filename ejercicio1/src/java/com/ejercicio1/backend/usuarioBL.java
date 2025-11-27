/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ejercicio1.backend;

/**
 *
 * @author josem
 */
public class usuarioBL {
    private int usuarioID = 0;
    private int usuarioRol = 0;
    private String usuarioNombre = "";
    private String usuarioCorreo = "";
    
    public usuarioBL() {
        
    }
    public usuarioBL(int id, int rol, String nombre, String correo){
        this.usuarioID = id;
        this.usuarioRol = rol;
        this.usuarioNombre = nombre;
        this.usuarioCorreo = correo;
    }
    
    public int getID(){
        return this.usuarioID;
    }
    public int getRol(){
        return this.usuarioRol;
    }
    public String getNombre(){
        return this.usuarioNombre;
    }
    public String getCorreo(){
        return this.usuarioCorreo;
    }
}

