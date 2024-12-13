/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cosaverde.service.impl;

import com.cosaverde.dao.ProvinciaDao;
import com.cosaverde.domain.Provincia;
import com.cosaverde.service.ProvinciaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author sfallas
 */
@Service
public class ProvinciaServiceImpl implements ProvinciaService {

    @Autowired
    private ProvinciaDao provinciaDao;

    @Override
    public List<Provincia> getAllProvincias() {
        return provinciaDao.findAll();
    }

}
